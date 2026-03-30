---
name: django-patterns
description: "Production-grade Django patterns and best practices. Covers project structure, models, DRF, services, caching, signals, middleware, N+1 prevention, and database optimization. Auto-invoked when working on Django/Python web projects."
auto_invoke: true
tags: [django, python, web, drf, orm, patterns]
---

# Django Patterns Skill

Production-grade Django patterns for building maintainable, performant web applications.

## When Claude Should Use This Skill

Claude will automatically invoke this skill when:
- Project uses Django (detected via `manage.py`, `settings.py`, `django` in requirements)
- Working on Django models, views, serializers, or middleware
- User mentions Django, DRF, or Django REST Framework

**Do NOT invoke when:**
- Project is Flask, FastAPI, or non-Django Python
- Working on frontend-only files in a Django project (HTML/CSS/JS with no Python changes)

## Project Structure

### Split Settings Pattern

```python
# settings/
# ├── __init__.py          (empty or imports default)
# ├── base.py              (shared settings)
# ├── development.py       (DEBUG=True, local DB)
# ├── production.py        (security, remote DB)
# └── test.py              (fast test DB, minimal middleware)

# settings/development.py
from .base import *

DEBUG = True
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': BASE_DIR / 'db.sqlite3',
    }
}

# Run with: DJANGO_SETTINGS_MODULE=myproject.settings.development
```

## Models

### Always Use Custom User Model

```python
# accounts/models.py
from django.contrib.auth.models import AbstractUser

class User(AbstractUser):
    """Custom user model -- MUST be set up before first migration."""
    pass

# settings/base.py
AUTH_USER_MODEL = 'accounts.User'
```

Set this up BEFORE running any migrations. Adding a custom User model later requires a full database reset.

### Custom QuerySet + Manager

```python
class PublishedQuerySet(models.QuerySet):
    def published(self):
        return self.filter(status='published', published_at__lte=timezone.now())

    def by_author(self, user):
        return self.filter(author=user)

class Article(models.Model):
    objects = PublishedQuerySet.as_manager()

# Usage: Article.objects.published().by_author(user)
```

## Django REST Framework

### Serializers

```python
class ArticleListSerializer(serializers.ModelSerializer):
    """Lightweight serializer for list views."""
    author_name = serializers.CharField(source='author.get_full_name', read_only=True)

    class Meta:
        model = Article
        fields = ['id', 'title', 'author_name', 'published_at']


class ArticleDetailSerializer(serializers.ModelSerializer):
    """Full serializer for detail views."""
    class Meta:
        model = Article
        fields = '__all__'
```

### ViewSets with Dynamic Serializers

```python
class ArticleViewSet(viewsets.ModelViewSet):
    queryset = Article.objects.select_related('author')

    def get_serializer_class(self):
        if self.action == 'list':
            return ArticleListSerializer
        return ArticleDetailSerializer

    def get_queryset(self):
        qs = super().get_queryset()
        if self.action == 'list':
            qs = qs.published()
        return qs

    @action(detail=True, methods=['post'])
    def publish(self, request, pk=None):
        article = self.get_object()
        article.publish()
        return Response(ArticleDetailSerializer(article).data)
```

## Service Layer

Keep business logic OUT of views and serializers.

```python
# services/article_service.py
from django.db import transaction

class ArticleService:
    @staticmethod
    @transaction.atomic
    def publish_article(article_id: int, published_by: User) -> Article:
        article = Article.objects.select_for_update().get(id=article_id)
        if article.status == 'published':
            raise ValidationError('Article already published')
        article.status = 'published'
        article.published_at = timezone.now()
        article.published_by = published_by
        article.save(update_fields=['status', 'published_at', 'published_by'])
        notify_subscribers(article)
        return article
```

**Rule**: Views handle HTTP. Serializers handle data shape. Services handle business logic.

## Caching

### Four Strategies

```python
# 1. View-level caching
from django.views.decorators.cache import cache_page

@cache_page(60 * 15)  # 15 minutes
def article_list(request):
    ...

# 2. Template fragment caching
# {% load cache %}
# {% cache 500 sidebar request.user.id %}
#   ... expensive template fragment ...
# {% endcache %}

# 3. Low-level caching
from django.core.cache import cache

def get_popular_articles():
    key = 'popular_articles'
    result = cache.get(key)
    if result is None:
        result = list(Article.objects.published().order_by('-views')[:10])
        cache.set(key, result, timeout=60 * 30)
    return result

# 4. QuerySet caching (django-cachalot or manual)
```

## Signals

```python
# signals.py
from django.db.models.signals import post_save
from django.dispatch import receiver

@receiver(post_save, sender=Article)
def on_article_published(sender, instance, created, **kwargs):
    if not created and instance.status == 'published':
        send_notification.delay(instance.id)

# apps.py
class ArticlesConfig(AppConfig):
    def ready(self):
        import articles.signals  # noqa: F401
```

**Warning**: Signals run synchronously. Use Celery tasks for heavy operations.

## Middleware

```python
class RequestTimingMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        import time
        start = time.monotonic()
        response = self.get_response(request)
        duration = time.monotonic() - start
        response['X-Request-Duration'] = f'{duration:.3f}s'
        return response
```

## N+1 Prevention

The #1 Django performance issue. Always use:

```python
# select_related: ForeignKey, OneToOneField (SQL JOIN)
Article.objects.select_related('author', 'category')

# prefetch_related: ManyToManyField, reverse ForeignKey (separate query)
Article.objects.prefetch_related('tags', 'comments')

# Combine both
Article.objects.select_related('author').prefetch_related('tags')
```

**Rule**: Every QuerySet in a view that accesses related objects MUST use `select_related` or `prefetch_related`.

## Bulk Operations

```python
# Bulk create (single INSERT)
Article.objects.bulk_create([
    Article(title=t, author=user) for t in titles
], batch_size=1000)

# Bulk update (single UPDATE)
articles = Article.objects.filter(status='draft')
for a in articles:
    a.status = 'archived'
Article.objects.bulk_update(articles, ['status'], batch_size=1000)
```

## Database Indexing

```python
class Article(models.Model):
    title = models.CharField(max_length=200)
    status = models.CharField(max_length=20, db_index=True)
    published_at = models.DateTimeField(null=True, db_index=True)
    author = models.ForeignKey(User, on_delete=models.CASCADE)

    class Meta:
        indexes = [
            models.Index(fields=['status', 'published_at']),  # composite
            models.Index(
                fields=['published_at'],
                condition=models.Q(status='published'),
                name='published_articles_idx',  # partial index
            ),
        ]
```

## Quality Checklist

Before completing Django work:
- [ ] Custom User model set up (not using default auth.User)
- [ ] No N+1 queries (select_related / prefetch_related used)
- [ ] Business logic in services, not views
- [ ] Settings split per environment
- [ ] Migrations tested (forward + backward)
- [ ] Sensitive data not exposed in serializers

Adapted from affaan-m/everything-claude-code django-patterns skill.
