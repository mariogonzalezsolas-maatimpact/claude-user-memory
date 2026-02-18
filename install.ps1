#Requires -Version 5.1
<#
.SYNOPSIS
    Agentic Substrate v5.1.1 - PowerShell Installer for Windows

.DESCRIPTION
    Native Windows installer for the Agentic Substrate system.
    Works without Git Bash, WSL, or any Unix tools.

.PARAMETER DryRun
    Show what would be installed without making changes

.PARAMETER Force
    Force reinstall even if already installed

.EXAMPLE
    .\install.ps1

.EXAMPLE
    .\install.ps1 -DryRun

.EXAMPLE
    .\install.ps1 -Force

.NOTES
    Version: 5.1.1
    Author: Agentic Substrate Team + Windows compatibility by mariogonzalezsolas-maatimpact
#>

param(
    [switch]$DryRun,
    [switch]$Force,
    [switch]$Help
)

$ErrorActionPreference = "Stop"
$VERSION = "5.1.1"
$CLAUDE_TARGET = Join-Path $env:USERPROFILE ".claude"
$SCRIPT_DIR = Split-Path -Parent $MyInvocation.MyCommand.Path
$CLAUDE_SOURCE = Join-Path $SCRIPT_DIR ".claude"
$MANIFEST_TEMPLATE = Join-Path $SCRIPT_DIR "manifest-template.json"
$BACKUP_LOCATION = $null

# ============================================================================
# UTILITY FUNCTIONS
# ============================================================================

function Write-Info {
    param([string]$Message)
    Write-Host "[INFO] $Message" -ForegroundColor Cyan
}

function Write-Success {
    param([string]$Message)
    Write-Host "[SUCCESS] $Message" -ForegroundColor Green
}

function Write-Warning {
    param([string]$Message)
    Write-Host "[WARNING] $Message" -ForegroundColor Yellow
}

function Write-Error {
    param([string]$Message)
    Write-Host "[ERROR] $Message" -ForegroundColor Red
}

function Show-Help {
    Write-Host @"
Agentic Substrate Installer v$VERSION (PowerShell)

Usage: .\install.ps1 [OPTIONS]

Options:
  -DryRun    Show what would be installed without installing
  -Force     Force reinstall even if already installed
  -Help      Show this help message

Examples:
  .\install.ps1              # Standard installation
  .\install.ps1 -DryRun      # Preview what will be installed
  .\install.ps1 -Force       # Reinstall even if already installed

For Git Bash users, use install.sh instead.
"@
}

function Test-JsonFile {
    param([string]$Path)

    try {
        $null = Get-Content $Path -Raw | ConvertFrom-Json
        return $true
    }
    catch {
        return $false
    }
}

function Get-JsonArray {
    param(
        [string]$Path,
        [string]$ArrayName
    )

    try {
        $json = Get-Content $Path -Raw | ConvertFrom-Json
        return $json.$ArrayName
    }
    catch {
        return @()
    }
}

# ============================================================================
# INSTALLATION FUNCTIONS
# ============================================================================

function Test-Prerequisites {
    Write-Info "Running pre-flight checks..."

    # Check source directory
    if (-not (Test-Path $CLAUDE_SOURCE)) {
        Write-Error "Source directory not found: $CLAUDE_SOURCE"
        Write-Error "Make sure you're running this script from the repository root"
        exit 1
    }

    # Check manifest
    if (-not (Test-Path $MANIFEST_TEMPLATE)) {
        Write-Error "Manifest template not found: $MANIFEST_TEMPLATE"
        exit 1
    }

    # Validate JSON
    if (-not (Test-JsonFile $MANIFEST_TEMPLATE)) {
        Write-Error "Manifest template is invalid JSON"
        exit 1
    }

    # Check if already installed (unless force)
    $versionFile = Join-Path $CLAUDE_TARGET ".agentic-substrate-version"
    if (-not $Force -and (Test-Path $versionFile)) {
        $installedVersion = Get-Content $versionFile -Raw
        if ($installedVersion.Trim() -eq $VERSION) {
            Write-Warning "Agentic Substrate v$VERSION is already installed"
            Write-Info "Use -Force to reinstall"
            exit 0
        }
    }

    Write-Success "Pre-flight checks passed"
}

function New-Backup {
    if (-not (Test-Path $CLAUDE_TARGET)) {
        Write-Info "No existing installation - skipping backup"
        return
    }

    $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
    $script:BACKUP_LOCATION = Join-Path $env:USERPROFILE ".claude.backup-$timestamp"

    if ($DryRun) {
        Write-Info "[DRY RUN] Would create backup: $BACKUP_LOCATION"
        return
    }

    Write-Info "Creating backup of existing installation..."

    try {
        Copy-Item -Path $CLAUDE_TARGET -Destination $BACKUP_LOCATION -Recurse -Force
        Write-Success "Backup created: $BACKUP_LOCATION"
    }
    catch {
        Write-Warning "Backup creation failed (continuing anyway): $_"
        $script:BACKUP_LOCATION = $null
    }
}

function Install-Files {
    Write-Info "Installing Agentic Substrate components..."

    # Create directory structure
    $directories = @(
        "agents", "skills", "commands", "hooks",
        "validators", "metrics", "templates", "data"
    )

    foreach ($dir in $directories) {
        $path = Join-Path $CLAUDE_TARGET $dir
        if (-not (Test-Path $path)) {
            if ($DryRun) {
                Write-Info "[DRY RUN] Would create directory: $dir"
            }
            else {
                New-Item -ItemType Directory -Path $path -Force | Out-Null
            }
        }
    }

    # Read managed files from manifest
    $files = Get-JsonArray -Path $MANIFEST_TEMPLATE -ArrayName "managed_files"

    if ($files.Count -eq 0) {
        Write-Error "Failed to read managed files from manifest"
        exit 1
    }

    $count = 0
    $total = $files.Count

    foreach ($file in $files) {
        $count++
        $sourceFile = Join-Path $CLAUDE_SOURCE $file
        $targetFile = Join-Path $CLAUDE_TARGET $file

        if (-not (Test-Path $sourceFile)) {
            Write-Warning "Source file not found (skipping): $file"
            continue
        }

        if ($DryRun) {
            Write-Info "[DRY RUN] Would install [$count/$total]: $file"
        }
        else {
            # Create parent directory if needed
            $targetDir = Split-Path -Parent $targetFile
            if (-not (Test-Path $targetDir)) {
                New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
            }

            # Copy file
            try {
                Copy-Item -Path $sourceFile -Destination $targetFile -Force

                # Progress logging
                if (($count % 5 -eq 0) -or ($count -eq $total)) {
                    Write-Info "Progress: $count/$total files installed"
                }
            }
            catch {
                Write-Warning "Failed to install: $file - $_"
            }
        }
    }

    Write-Success "All managed files installed ($count files)"
}

function Merge-ClaudeMd {
    $source = Join-Path $CLAUDE_SOURCE "templates\CLAUDE.md.user-level"
    $target = Join-Path $CLAUDE_TARGET "CLAUDE.md"
    $backup = Join-Path $CLAUDE_TARGET "CLAUDE.md.backup"

    if (-not (Test-Path $source)) {
        Write-Warning "CLAUDE.md.user-level template not found (skipping)"
        return
    }

    if ($DryRun) {
        if (Test-Path $target) {
            Write-Info "[DRY RUN] Would smart-merge user-level CLAUDE.md"
        }
        else {
            Write-Info "[DRY RUN] Would install user-level CLAUDE.md"
        }
        return
    }

    # If no existing CLAUDE.md, just copy template
    if (-not (Test-Path $target)) {
        Write-Info "Installing user-level CLAUDE.md..."
        Copy-Item -Path $source -Destination $target -Force
        Write-Success "User-level CLAUDE.md installed"
        return
    }

    # Existing CLAUDE.md found - smart merge
    Write-Info "Existing CLAUDE.md found - performing smart merge..."

    # Create backup
    Copy-Item -Path $target -Destination $backup -Force

    # Create merged version
    $sourceContent = Get-Content $source -Raw
    $targetContent = Get-Content $target -Raw

    $mergedContent = @"
$sourceContent

---

# USER CUSTOMIZATIONS (preserved from previous installation)

$targetContent
"@

    Set-Content -Path $target -Value $mergedContent -Force
    Write-Success "User-level CLAUDE.md smart-merged"
    Write-Info "Original backed up to: CLAUDE.md.backup"
}

function Install-McpConfig {
    $source = Join-Path $CLAUDE_SOURCE "data\mcp-config-template.json"
    $target = Join-Path $CLAUDE_TARGET "data\mcp-config.json"

    if (-not (Test-Path $source)) {
        Write-Warning "MCP config template not found (skipping)"
        return
    }

    if ($DryRun) {
        if (Test-Path $target) {
            Write-Info "[DRY RUN] Would preserve existing MCP config"
        }
        else {
            Write-Info "[DRY RUN] Would install MCP config from template"
        }
        return
    }

    # If MCP config already exists, preserve it
    if (Test-Path $target) {
        Write-Info "Existing MCP config found - preserving user configuration"
        Write-Success "MCP config preserved"
        return
    }

    # No existing config - install from template
    Write-Info "Installing MCP config from template..."
    $dataDir = Join-Path $CLAUDE_TARGET "data"
    if (-not (Test-Path $dataDir)) {
        New-Item -ItemType Directory -Path $dataDir -Force | Out-Null
    }

    Copy-Item -Path $source -Destination $target -Force
    Write-Success "MCP config installed from template"
}

function Install-McpServers {
    if ($DryRun) {
        Write-Info "[DRY RUN] Would configure MCP servers"
        return
    }

    Write-Info "Configuring MCP servers..."

    # Check if claude CLI is available
    $claudeCmd = Get-Command "claude" -ErrorAction SilentlyContinue

    if ($claudeCmd) {
        Write-Info "Installing DeepWiki MCP..."
        try {
            & claude mcp add -s user -t http deepwiki https://mcp.deepwiki.com/mcp 2>$null
            Write-Success "DeepWiki MCP configured"
        }
        catch {
            Write-Warning "DeepWiki MCP installation failed (non-critical)"
            Write-Info "You can install manually later: claude mcp add -s user -t http deepwiki https://mcp.deepwiki.com/mcp"
        }
    }
    else {
        Write-Warning "Claude CLI not found, skipping MCP setup"
        Write-Info "Install Claude CLI then run: claude mcp add -s user -t http deepwiki https://mcp.deepwiki.com/mcp"
    }
}

function New-Manifest {
    if ($DryRun) {
        Write-Info "[DRY RUN] Would generate installation manifest"
        return
    }

    Write-Info "Generating installation manifest..."

    $manifest = Join-Path $CLAUDE_TARGET ".agentic-substrate-manifest.json"
    $timestamp = Get-Date -Format "yyyy-MM-ddTHH:mm:ssZ"

    try {
        $data = Get-Content $MANIFEST_TEMPLATE -Raw | ConvertFrom-Json
        $data | Add-Member -NotePropertyName "installed_at" -NotePropertyValue $timestamp -Force
        $data | Add-Member -NotePropertyName "installed_by" -NotePropertyValue "install.ps1" -Force

        $data | ConvertTo-Json -Depth 10 | Set-Content $manifest -Force
        Write-Success "Installation manifest created"
    }
    catch {
        # Fallback: copy template as-is
        Copy-Item -Path $MANIFEST_TEMPLATE -Destination $manifest -Force
        Write-Success "Installation manifest created (from template)"
    }
}

function Write-Version {
    if ($DryRun) {
        Write-Info "[DRY RUN] Would write version file: $VERSION"
        return
    }

    $versionFile = Join-Path $CLAUDE_TARGET ".agentic-substrate-version"
    Set-Content -Path $versionFile -Value $VERSION -Force
    Write-Success "Version file created: v$VERSION"
}

function New-RollbackScript {
    if ($DryRun) {
        Write-Info "[DRY RUN] Would generate rollback script"
        return
    }

    if (-not $BACKUP_LOCATION) {
        Write-Info "No backup created - skipping rollback script"
        return
    }

    $rollbackScript = Join-Path $CLAUDE_TARGET "rollback-to-previous.ps1"

    $content = @"
# Agentic Substrate Rollback Script
`$BACKUP_LOCATION = "$BACKUP_LOCATION"
`$VERSION = "$VERSION"

Write-Host "Rolling back Agentic Substrate..."
Write-Host "  From: v`$VERSION"
Write-Host "  Backup: `$BACKUP_LOCATION"
Write-Host ""

`$response = Read-Host "Proceed with rollback? (y/N)"
if (`$response -ne "y" -and `$response -ne "Y") {
    Write-Host "Rollback cancelled"
    exit 1
}

if (-not (Test-Path `$BACKUP_LOCATION)) {
    Write-Host "ERROR: Backup not found: `$BACKUP_LOCATION" -ForegroundColor Red
    exit 1
}

`$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
`$rollbackBackup = Join-Path `$env:USERPROFILE ".claude.rollback-backup-`$timestamp"

Write-Host "Backing up current state to `$rollbackBackup"
Copy-Item -Path (Join-Path `$env:USERPROFILE ".claude") -Destination `$rollbackBackup -Recurse -Force

Write-Host "Restoring from backup..."
Remove-Item -Path (Join-Path `$env:USERPROFILE ".claude") -Recurse -Force
Copy-Item -Path `$BACKUP_LOCATION -Destination (Join-Path `$env:USERPROFILE ".claude") -Recurse -Force

Write-Host "Rollback complete!" -ForegroundColor Green
"@

    Set-Content -Path $rollbackScript -Value $content -Force
    Write-Success "Rollback script created"
}

function Test-Installation {
    if ($DryRun) {
        Write-Info "[DRY RUN] Would validate installation"
        return
    }

    Write-Info "Validating installation..."

    $errors = 0

    # Check version file
    $versionFile = Join-Path $CLAUDE_TARGET ".agentic-substrate-version"
    if (-not (Test-Path $versionFile)) {
        Write-Error "Version file missing"
        $errors++
    }

    # Check manifest
    $manifestFile = Join-Path $CLAUDE_TARGET ".agentic-substrate-manifest.json"
    if (-not (Test-Path $manifestFile)) {
        Write-Error "Manifest file missing"
        $errors++
    }
    else {
        $managedFiles = Get-JsonArray -Path $manifestFile -ArrayName "managed_files"
        Write-Info "Expected files: $($managedFiles.Count)"
    }

    if ($errors -eq 0) {
        Write-Success "Installation validation passed"
    }
    else {
        Write-Error "Installation validation failed with $errors error(s)"
        exit 1
    }
}

function Show-Summary {
    Write-Host ""
    Write-Host ("=" * 60) -ForegroundColor Cyan
    Write-Success "Agentic Substrate v$VERSION installed successfully!"
    Write-Host ("=" * 60) -ForegroundColor Cyan
    Write-Host ""

    if ($DryRun) {
        Write-Host "DRY RUN COMPLETE - No changes were made"
        Write-Host "Run without -DryRun to perform actual installation"
        Write-Host ""
        return
    }

    Write-Host "Installation Summary:"
    Write-Host "  Location: $CLAUDE_TARGET"
    Write-Host "  Version: $VERSION"
    Write-Host "  Platform: Windows (PowerShell)"
    Write-Host "  Agents: 15 | Skills: 5 | Commands: 10"
    Write-Host ""

    if ($BACKUP_LOCATION) {
        Write-Host "Backup Information:"
        Write-Host "  Backup: $BACKUP_LOCATION"
        Write-Host "  Rollback: $CLAUDE_TARGET\rollback-to-previous.ps1"
        Write-Host ""
    }

    Write-Host "Quick Start:"
    Write-Host "  1. Start Claude Code CLI"
    Write-Host "  2. Try: /workflow Add feature X"
    Write-Host ""

    Write-Host "Documentation:"
    Write-Host "  $CLAUDE_TARGET\CLAUDE.md"
    Write-Host "  $CLAUDE_TARGET\templates\"
    Write-Host ""
}

# ============================================================================
# MAIN EXECUTION
# ============================================================================

function Main {
    if ($Help) {
        Show-Help
        exit 0
    }

    Write-Host "Agentic Substrate v$VERSION - Windows PowerShell Installation"
    Write-Host ("=" * 60) -ForegroundColor Cyan
    Write-Host "Platform: Windows | PowerShell: $($PSVersionTable.PSVersion)"
    Write-Host ""

    if ($DryRun) {
        Write-Warning "DRY RUN MODE - No changes will be made"
        Write-Host ""
    }

    Test-Prerequisites
    New-Backup
    Install-Files
    Merge-ClaudeMd
    Install-McpConfig
    Install-McpServers
    New-Manifest
    Write-Version
    New-RollbackScript
    Test-Installation
    Show-Summary
}

# Run main
Main
