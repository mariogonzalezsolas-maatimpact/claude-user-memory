---
name: generate-docs
description: "Genera o migra la estructura .claude/ para cualquier proyecto. Se activa cuando el usuario pide configurar Claude para su proyecto, generar documentacion IA, o setup .claude."
auto_invoke: true
tags: [documentation, generation, migration, spanish, setup, claude]
---

# Generate Docs Skill

Genera la estructura de documentacion `.claude/` estandar para cualquier proyecto, adaptada mediante entrevista agentica. Todo el contenido en espanol.

## When Claude Should Use This Skill

Claude will automatically invoke this skill when the user says:
- "genera documentacion para la IA" / "genera docs para claude"
- "configura claude para este proyecto" / "configurar .claude"
- "setup .claude" / "crear estructura .claude"
- "preparar proyecto para IA" / "inicializar claude"
- "documentacion para la inteligencia artificial"
- "/generate-docs"

**Do NOT invoke when:**
- User is editing existing .claude files (not creating structure)
- User is working within the Agentic Substrate source repo itself
- User says "organize" without mentioning .claude or AI docs (use project-organization instead)
- User is asking about what .claude is or how it works (just explain)

## Estructura Estandar de Referencia

```
proyecto/
├── CLAUDE.md                        -> instrucciones de equipo
├── CLAUDE.local.md                  -> notas personales (gitignored)
└── .claude/
    ├── settings.json                -> permisos + configuracion
    ├── settings.local.json          -> permisos personales (gitignored)
    ├── commands/                    -> comandos slash personalizados
    │   ├── revision.md              -> /project:revision
    │   ├── fix-issue.md             -> /project:fix-issue
    │   └── desplegar.md             -> /project:desplegar
    ├── rules/                       -> instrucciones modulares
    │   ├── estilo-de-codigo.md
    │   ├── pruebas.md
    │   └── convenciones-api.md
    ├── skills/                      -> flujos automaticos
    │   └── [nombre-skill]/
    │       └── skill.md
    └── agents/                      -> personas subagentes
        ├── revisor-codigo.md
        └── auditor-seguridad.md
```

## Protocolo de Ejecucion

### Fase 1: Deteccion del Estado

1. `Glob .claude/**/*` para inventariar estructura existente
2. `Read CLAUDE.md` si existe
3. Clasificar:
   - **NUEVO**: No existe `.claude/` ni `CLAUDE.md`
   - **PARCIAL**: Solo uno de los dos existe
   - **MIGRAR**: `.claude/` existe pero no sigue la estructura estandar
   - **COMPLETO**: Estructura estandar presente

### Fase 2: Entrevista Agentica

Presentar 3 bloques de preguntas multi-opcion en espanol. Ver `/generate-docs` command para la lista completa de preguntas.

Mapear respuestas a templates:
- Stack -> que comandos/reglas generar
- Tipo de proyecto -> estructura de tabla de navegacion en CLAUDE.md
- Testing -> contenido de pruebas.md
- Deploy -> contenido de desplegar.md
- Tamano equipo -> reglas de colaboracion
- Tareas IA -> prioridad de comandos
- Convenciones -> contenido de estilo-de-codigo.md
- Archivos protegidos -> deny list en settings.json + warning en CLAUDE.md

### Fase 3: Generacion

Usar los templates definidos en el comando `/generate-docs`. Adaptar cada archivo segun las respuestas de la entrevista. No generar contenido generico -- cada archivo debe reflejar el stack y preferencias del usuario.

### Fase 4: Migracion (cuando `.claude/` ya existe)

Protocolo de migracion:
1. Inventariar todos los archivos
2. Clasificar: estandar | mal ubicado | desconocido | faltante
3. Mover automaticamente (NUNCA borrar)
4. Archivos desconocidos -> `.claude/legacy/`
5. Actualizar referencias en CLAUDE.md
6. Reportar tabla de cambios al usuario

### Fase 5: Post-Generacion

1. Actualizar `.gitignore` con `CLAUDE.local.md` y `.claude/settings.local.json`
2. Crear `CLAUDE.local.md` vacio con header en espanol
3. Mostrar resumen de archivos creados/movidos

## Calidad

- [ ] CLAUDE.md tiene tabla "Donde Encontrar Que"
- [ ] Contenido adaptado a respuestas (no generico)
- [ ] .gitignore actualizado
- [ ] Si migracion: ningun archivo borrado, todos movidos
- [ ] Resumen mostrado al usuario
