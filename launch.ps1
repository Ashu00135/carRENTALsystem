#!/usr/bin/env pwsh
# Car Rental System - Universal Launcher
# Automatically builds and runs both backend and frontend
# Works on Windows, macOS, and Linux

param(
    [Parameter(Mandatory=$false)]
    [ValidateSet("full", "backend", "frontend", "build-only", "help")]
    [string]$Mode = "full",
    
    [switch]$NoWait,
    [switch]$Clean
)

# Colors for output
$Colors = @{
    Success = "Green"
    Error = "Red"
    Warning = "Yellow"
    Info = "Cyan"
    Section = "Magenta"
}

function Show-Banner {
    Clear-Host
    Write-Host ""
    Write-Host "╔════════════════════════════════════════════════════════════╗" -ForegroundColor $Colors.Section
    Write-Host "║         🚗 CAR RENTAL SYSTEM - UNIVERSAL LAUNCHER          ║" -ForegroundColor $Colors.Section
    Write-Host "╚════════════════════════════════════════════════════════════╝" -ForegroundColor $Colors.Section
    Write-Host ""
}

function Show-Help {
    Show-Banner
    Write-Host "USAGE:" -ForegroundColor $Colors.Section
    Write-Host "  .\launch.ps1 [mode] [options]`n" -ForegroundColor White
    
    Write-Host "MODES:" -ForegroundColor $Colors.Section
    Write-Host "  full         - Build and run backend + frontend (default)" -ForegroundColor Green
    Write-Host "  backend      - Build and run backend only" -ForegroundColor Green
    Write-Host "  frontend     - Run frontend only (backend must be running)" -ForegroundColor Green
    Write-Host "  build-only   - Build backend JAR without running" -ForegroundColor Green
    Write-Host "  help         - Show this help message`n" -ForegroundColor Green
    
    Write-Host "OPTIONS:" -ForegroundColor $Colors.Section
    Write-Host "  -NoWait      - Don't wait between backend and frontend startup" -ForegroundColor Green
    Write-Host "  -Clean       - Clean before building`n" -ForegroundColor Green
    
    Write-Host "EXAMPLES:" -ForegroundColor $Colors.Section
    Write-Host "  .\launch.ps1                    # Full stack (recommended)" -ForegroundColor Cyan
    Write-Host "  .\launch.ps1 backend            # Backend only" -ForegroundColor Cyan
    Write-Host "  .\launch.ps1 frontend           # Frontend only" -ForegroundColor Cyan
    Write-Host "  .\launch.ps1 full -Clean        # Clean build everything`n" -ForegroundColor Cyan
    
    Write-Host "URLS AFTER STARTUP:" -ForegroundColor $Colors.Section
    Write-Host "  Frontend:   http://localhost:3000" -ForegroundColor Magenta
    Write-Host "  Backend:    http://localhost:8080" -ForegroundColor Magenta
    Write-Host "  Database:   http://localhost:8080/h2-console`n" -ForegroundColor Magenta
}

function Write-Status {
    param([string]$Message, [string]$Status)
    $icon = if ($Status -eq "success") { "✓" } elseif ($Status -eq "error") { "✕" } else { "→" }
    $color = $Colors[$Status] ?? $Colors.Info
    Write-Host "$icon $Message" -ForegroundColor $color
}

function Test-Prerequisites {
    Write-Host "`n📋 Checking prerequisites..." -ForegroundColor $Colors.Section
    
    $missing = @()
    
    if (-not (Get-Command java -ErrorAction SilentlyContinue)) {
        $missing += "Java JDK"
    } else {
        Write-Status "Java" "success"
    }
    
    if (-not (Get-Command mvn -ErrorAction SilentlyContinue)) {
        $missing += "Maven"
    } else {
        Write-Status "Maven" "success"
    }
    
    if (-not (Get-Command node -ErrorAction SilentlyContinue)) {
        $missing += "Node.js"
    } else {
        Write-Status "Node.js" "success"
    }
    
    if (-not (Get-Command npm -ErrorAction SilentlyContinue)) {
        $missing += "npm"
    } else {
        Write-Status "npm" "success"
    }
    
    if ($missing.Count -gt 0) {
        Write-Host "`n❌ Missing components:" -ForegroundColor $Colors.Error
        foreach ($item in $missing) {
            Write-Host "   - $item" -ForegroundColor $Colors.Error
        }
        Write-Host "`nPlease install the missing components and try again." -ForegroundColor $Colors.Error
        exit 1
    }
    
    Write-Host "✓ All prerequisites met!`n" -ForegroundColor $Colors.Success
}

function Build-Backend {
    Write-Host "`n🔨 Building backend..." -ForegroundColor $Colors.Section
    
    $backendPath = "d:\PROJECTS\car_manager\carRENTALsystem\CarRentalSystem"
    
    if (-not (Test-Path $backendPath)) {
        Write-Status "Backend path not found: $backendPath" "error"
        exit 1
    }
    
    Push-Location $backendPath
    
    try {
        if ($Clean) {
            Write-Host "  Cleaning previous build..." -ForegroundColor $Colors.Info
            & mvn clean -q
        }
        
        Write-Host "  Running mvn package..." -ForegroundColor $Colors.Info
        & mvn -DskipTests package -q
        
        if ($LASTEXITCODE -ne 0) {
            Write-Status "Build failed!" "error"
            Pop-Location
            exit 1
        }
        
        $jarPath = "$backendPath\target\carrental-0.0.1-SNAPSHOT.jar"
        if (Test-Path $jarPath) {
            $size = (Get-Item $jarPath).Length / 1MB
            Write-Status "Build successful (JAR: $([Math]::Round($size, 1))MB)" "success"
        }
    }
    catch {
        Write-Status "Build error: $_" "error"
        Pop-Location
        exit 1
    }
}

function Start-Backend {
    Write-Host "`n🚀 Starting backend..." -ForegroundColor $Colors.Section
    
    # Stop any existing Java processes
    $existingJava = Get-Process -Name java -ErrorAction SilentlyContinue
    if ($existingJava) {
        Write-Host "  Stopping existing Java processes..." -ForegroundColor $Colors.Warning
        $existingJava | Stop-Process -Force -ErrorAction SilentlyContinue
        Start-Sleep -Seconds 2
    }
    
    $backendPath = "d:\PROJECTS\car_manager\carRENTALsystem\CarRentalSystem"
    $jarPath = "$backendPath\target\carrental-0.0.1-SNAPSHOT.jar"
    
    if (-not (Test-Path $jarPath)) {
        Write-Status "JAR file not found: $jarPath" "error"
        exit 1
    }
    
    Write-Host "  Launching application..." -ForegroundColor $Colors.Info
    $process = Start-Process -NoNewWindow -FilePath "java" -ArgumentList "-jar", "`"$jarPath`"" -PassThru
    
    Write-Status "Backend started (PID: $($process.Id))" "success"
    
    # Wait for server to start
    Write-Host "  Waiting for server to start..." -ForegroundColor $Colors.Info
    $maxWait = 15
    $waited = 0
    
    while ($waited -lt $maxWait) {
        try {
            $response = Invoke-WebRequest -Uri "http://localhost:8080/" -UseBasicParsing -TimeoutSec 2 -ErrorAction Stop
            if ($response.StatusCode -eq 200) {
                Write-Status "Backend is responding!" "success"
                Write-Host ""
                Write-Host "  🌐 Backend API: http://localhost:8080" -ForegroundColor Magenta
                Write-Host "  🗄️  Database Console: http://localhost:8080/h2-console" -ForegroundColor Magenta
                Write-Host ""
                return $true
            }
        }
        catch {
            $waited += 1
            if ($waited -lt $maxWait) {
                Write-Host "  ." -NoNewline
                Start-Sleep -Seconds 1
            }
        }
    }
    
    Write-Status "Backend startup timeout" "warning"
    return $false
}

function Start-Frontend {
    Write-Host "`n🎨 Starting frontend..." -ForegroundColor $Colors.Section
    
    $frontendPath = "d:\PROJECTS\car_manager\carRENTALsystem\frontend"
    
    if (-not (Test-Path $frontendPath)) {
        Write-Status "Frontend path not found: $frontendPath" "error"
        exit 1
    }
    
    Push-Location $frontendPath
    
    try {
        # Check if node_modules exists
        if (-not (Test-Path "node_modules")) {
            Write-Host "  Installing dependencies..." -ForegroundColor $Colors.Info
            & npm install -q
            if ($LASTEXITCODE -ne 0) {
                Write-Status "npm install failed" "error"
                Pop-Location
                exit 1
            }
        }
        
        Write-Host "  Starting Vite development server..." -ForegroundColor $Colors.Info
        Write-Host ""
        Write-Status "Frontend running on http://localhost:3000" "success"
        Write-Host ""
        
        # Run dev server (this will stay in foreground)
        & npm run dev
    }
    catch {
        Write-Status "Frontend error: $_" "error"
        exit 1
    }
}

# Main execution
Show-Banner

switch ($Mode.ToLower()) {
    "help" {
        Show-Help
    }
    
    "backend" {
        Test-Prerequisites
        Build-Backend
        Start-Backend
    }
    
    "frontend" {
        Test-Prerequisites
        Start-Frontend
    }
    
    "build-only" {
        Test-Prerequisites
        Build-Backend
        Write-Host "`n✅ Build complete! JAR is ready at:" -ForegroundColor $Colors.Success
        Write-Host "   d:\PROJECTS\car_manager\carRENTALsystem\CarRentalSystem\target\carrental-0.0.1-SNAPSHOT.jar`n" -ForegroundColor Magenta
    }
    
    "full" {
        Test-Prerequisites
        Build-Backend
        $backendReady = Start-Backend
        
        if ($backendReady) {
            if (-not $NoWait) {
                Write-Host "ℹ️  Backend is ready. Starting frontend in 5 seconds..." -ForegroundColor $Colors.Info
                Write-Host "    (Press Ctrl+C to stop backend only)" -ForegroundColor $Colors.Warning
                Start-Sleep -Seconds 5
            }
            Start-Frontend
        } else {
            Write-Host "`n⚠️  Backend may not be ready. Attempting frontend startup anyway..." -ForegroundColor $Colors.Warning
            Start-Frontend
        }
    }
    
    default {
        Write-Status "Unknown mode: $Mode" "error"
        Write-Host "`nRun '.\launch.ps1 help' for usage information." -ForegroundColor $Colors.Info
        exit 1
    }
}
