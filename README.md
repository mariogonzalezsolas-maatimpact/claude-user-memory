# Agentic Substrate v4.1

**Research-first development system for Claude Code CLI**

> No API hallucinations. No coding from stale training data. Research -> Plan -> Implement.

[English](#english) | [Espanol](#espanol)

---

<a name="english"></a>
## Quick Start

### macOS / Linux / WSL

```bash
git clone https://github.com/mariogonzalezsolas-maatimpact/claude-user-memory.git
cd claude-user-memory
./install.sh
```

### Windows (Git Bash)

```bash
git clone https://github.com/mariogonzalezsolas-maatimpact/claude-user-memory.git
cd claude-user-memory
./install.sh
```

### Windows (PowerShell)

```powershell
git clone https://github.com/mariogonzalezsolas-maatimpact/claude-user-memory.git
cd claude-user-memory
.\install.ps1
```

### Use

```bash
/workflow Add Redis caching to ProductService
```

---

## What You Get

- **9 Agents** - Orchestration, research, planning, implementation, debugging, deployment
- **5 Skills** - Auto-invoked capabilities for research, planning, validation, patterns, context
- **5 Commands** - `/workflow`, `/research`, `/plan`, `/implement`, `/context`
- **Quality Gates** - Research >= 80, Plans >= 85, Tests passing, 3-retry circuit breaker
- **Memory** - Knowledge graph persists across sessions

---

## Usage

**Full automation:**
```bash
/workflow Add authentication with JWT tokens
```

**Step-by-step:**
```bash
/research Redis for Node.js v5.0
/plan Redis caching implementation
/implement
```

**Direct agents:**
```bash
@chief-architect Build payment system
@docs-researcher Research Stripe API
@brahma-deployer Deploy v2.5.0
```

---

## How It Works

1. **Research** (< 2 min) - Fetch version-accurate docs before coding
2. **Plan** (< 3 min) - Create minimal-change blueprint with rollback
3. **Implement** (< 10 min) - Execute with TDD + self-correction
4. **Learn** - Auto-capture patterns to knowledge graph

Quality gates block bad inputs. Circuit breaker stops infinite loops.

---

## Installation

### Platform Support

| Platform | Script | Status |
|----------|--------|--------|
| macOS | `./install.sh` | Full support |
| Linux | `./install.sh` | Full support |
| WSL | `./install.sh` | Full support |
| Windows (Git Bash) | `./install.sh` | Full support |
| Windows (MSYS2) | `./install.sh` | Full support |
| Windows (PowerShell) | `.\install.ps1` | Full support |
| Windows (cmd) | N/A | Use PowerShell |

### Requirements

**Minimal:** bash and git only (for install.sh) or PowerShell 5.1+ (for install.ps1)

**Optional:** python3/python for enhanced JSON handling

### What Gets Installed

**Location:** `~/.claude/` (or `%USERPROFILE%\.claude` on Windows)

**Preserves:**
- All data in `~/.claude/data/`
- Your `CLAUDE.md` customizations (smart-merged)
- Modified files (detected by checksum)
- Knowledge files and patterns

### Upgrade

```bash
./install.sh          # bash
.\install.ps1         # PowerShell
```

Your data and customizations are automatically preserved.

### Selective Update

```bash
./update.sh    # Only update changed files
```

---

## Configuration

```bash
./customize.sh                              # Interactive menu
./customize.sh --enable-mcp memory          # Enable MCP servers
./customize.sh --list-mcps                  # View configuration
```

---

## Uninstall

```bash
./uninstall.sh --dry-run    # Preview what will be removed
./uninstall.sh              # Remove (preserves data)
```

---

## Documentation

- [Agents Overview](.claude/templates/agents-overview.md) - All 9 agents
- [Skills Overview](.claude/templates/skills-overview.md) - Auto-invoked capabilities
- [Workflows Overview](.claude/templates/workflows-overview.md) - Development patterns
- [Installation Behavior](INSTALLATION-BEHAVIOR.md) - Data preservation details
- [Release Notes](RELEASE-NOTES-V4.md) - v4.0/4.1 features

---

## Research Foundation

Built on Anthropic research (2024-2025):
- Extended Thinking: 54% improvement on complex tasks
- Multi-Agent Orchestration: 90.2% performance improvement
- Contextual Retrieval: 49-67% better accuracy

---

## Fork Improvements

This fork by [mariogonzalezsolas-maatimpact](https://github.com/mariogonzalezsolas-maatimpact) adds:

- **Native Windows Support** - Works with Git Bash, MSYS2, and PowerShell
- **PowerShell Installer** - `install.ps1` for Windows users without bash
- **Path Conversion** - Automatic Unix-to-Windows path conversion for Python
- **Dynamic Python Detection** - Works with `python3` or `python`
- **Bilingual Documentation** - English and Spanish

**Upstream:** [VAMFI/claude-user-memory](https://github.com/VAMFI/claude-user-memory)

---

## License

MIT License - See [LICENSE](LICENSE)

---

<a name="espanol"></a>
# Agentic Substrate v4.1 (Espanol)

**Sistema de desarrollo basado en investigacion para Claude Code CLI**

> Sin alucinaciones de APIs. Sin codigo basado en datos de entrenamiento obsoletos. Investigar -> Planificar -> Implementar.

---

## Inicio Rapido

### macOS / Linux / WSL

```bash
git clone https://github.com/mariogonzalezsolas-maatimpact/claude-user-memory.git
cd claude-user-memory
./install.sh
```

### Windows (Git Bash)

```bash
git clone https://github.com/mariogonzalezsolas-maatimpact/claude-user-memory.git
cd claude-user-memory
./install.sh
```

### Windows (PowerShell)

```powershell
git clone https://github.com/mariogonzalezsolas-maatimpact/claude-user-memory.git
cd claude-user-memory
.\install.ps1
```

### Uso

```bash
/workflow Agregar cache Redis a ProductService
```

---

## Que Incluye

- **9 Agentes** - Orquestacion, investigacion, planificacion, implementacion, depuracion, despliegue
- **5 Habilidades** - Capacidades auto-invocadas para investigacion, planificacion, validacion, patrones, contexto
- **5 Comandos** - `/workflow`, `/research`, `/plan`, `/implement`, `/context`
- **Puertas de Calidad** - Investigacion >= 80, Planes >= 85, Tests pasando, circuit breaker de 3 reintentos
- **Memoria** - Grafo de conocimiento persistente entre sesiones

---

## Uso

**Automatizacion completa:**
```bash
/workflow Agregar autenticacion con tokens JWT
```

**Paso a paso:**
```bash
/research Redis para Node.js v5.0
/plan Implementacion de cache Redis
/implement
```

**Agentes directos:**
```bash
@chief-architect Construir sistema de pagos
@docs-researcher Investigar API de Stripe
@brahma-deployer Desplegar v2.5.0
```

---

## Como Funciona

1. **Investigar** (< 2 min) - Obtener documentacion actualizada antes de programar
2. **Planificar** (< 3 min) - Crear plan de cambios minimos con rollback
3. **Implementar** (< 10 min) - Ejecutar con TDD + auto-correccion
4. **Aprender** - Capturar patrones automaticamente al grafo de conocimiento

Las puertas de calidad bloquean entradas incorrectas. El circuit breaker detiene bucles infinitos.

---

## Instalacion

### Soporte de Plataformas

| Plataforma | Script | Estado |
|------------|--------|--------|
| macOS | `./install.sh` | Soporte completo |
| Linux | `./install.sh` | Soporte completo |
| WSL | `./install.sh` | Soporte completo |
| Windows (Git Bash) | `./install.sh` | Soporte completo |
| Windows (MSYS2) | `./install.sh` | Soporte completo |
| Windows (PowerShell) | `.\install.ps1` | Soporte completo |
| Windows (cmd) | N/A | Usar PowerShell |

### Requisitos

**Minimos:** solo bash y git (para install.sh) o PowerShell 5.1+ (para install.ps1)

**Opcional:** python3/python para manejo mejorado de JSON

### Que Se Instala

**Ubicacion:** `~/.claude/` (o `%USERPROFILE%\.claude` en Windows)

**Preserva:**
- Todos los datos en `~/.claude/data/`
- Tus personalizaciones de `CLAUDE.md` (fusion inteligente)
- Archivos modificados (detectados por checksum)
- Archivos de conocimiento y patrones

### Actualizar

```bash
./install.sh          # bash
.\install.ps1         # PowerShell
```

Tus datos y personalizaciones se preservan automaticamente.

---

## Mejoras de este Fork

Este fork por [mariogonzalezsolas-maatimpact](https://github.com/mariogonzalezsolas-maatimpact) agrega:

- **Soporte Nativo de Windows** - Funciona con Git Bash, MSYS2 y PowerShell
- **Instalador PowerShell** - `install.ps1` para usuarios de Windows sin bash
- **Conversion de Rutas** - Conversion automatica de rutas Unix a Windows para Python
- **Deteccion Dinamica de Python** - Funciona con `python3` o `python`
- **Documentacion Bilingue** - Ingles y Espanol

**Upstream:** [VAMFI/claude-user-memory](https://github.com/VAMFI/claude-user-memory)

---

**Version:** 4.1.0
**Lanzamiento:** Noviembre 22, 2025
**Estado:** Listo para Produccion

*Investigar -> Planificar -> Implementar -> Aprender*
