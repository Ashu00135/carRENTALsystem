# Car Rental System - Quick Launcher
# Simple script to build and run the application

param(
    [Parameter(Mandatory=$false)]
    [string]$Mode = "full"
)

$ErrorActionPreference = "Stop"

Write-Host "`n╔════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║  🚗 CAR RENTAL SYSTEM - LAUNCHER               ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Define paths
$projectRoot = "d:\PROJECTS\car_manager\carRENTALsystem"
$backendPath = "$projectRoot\CarRentalSystem"
$frontendPath = "$projectRoot\frontend"

if ($Mode -eq "help" -or $Mode -eq "-h" -or $Mode -eq "--help") {
    Write-Host "USAGE: .\launch.ps1 [mode]`n" -ForegroundColor Yellow
    Write-Host "MODES:" -ForegroundColor Yellow
    Write-Host "  full       - Build and run backend + frontend (default)" -ForegroundColor Green
    Write-Host "  backend    - Build and run backend only" -ForegroundColor Green
    Write-Host "  frontend   - Run frontend only" -ForegroundColor Green
    Write-Host "  build      - Build backend JAR only`n" -ForegroundColor Green
    exit 0
}

function Build-Backend {
    Write-Host "🔨 Building backend..." -ForegroundColor Yellow
    Set-Location $backendPath
    & mvn clean package -DskipTests -q
    Write-Host "✓ Backend build complete`n" -ForegroundColor Green
}

function Start-Backend {
    Write-Host "🚀 Starting backend..." -ForegroundColor Yellow
    
    # Stop existing Java processes
    Get-Process java -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 2
    
    $jar = "$backendPath\target\carrental-0.0.1-SNAPSHOT.jar"
    Start-Process -NoNewWindow -FilePath java -ArgumentList "-jar", "`"$jar`"" -PassThru | Out-Null
    
    Write-Host "  Waiting for backend to start..." -ForegroundColor Gray
    Start-Sleep -Seconds 8
    
    try {
        $response = Invoke-WebRequest http://localhost:8080/ -UseBasicParsing -TimeoutSec 3 -ErrorAction Stop
        Write-Host "✓ Backend is running on http://localhost:8080`n" -ForegroundColor Green
        return $true
    }
    catch {
        Write-Host "⚠️  Backend startup in progress...`n" -ForegroundColor Yellow
        return $false
    }
}

function Start-Frontend {
    Write-Host "🎨 Starting frontend..." -ForegroundColor Yellow
    Set-Location $frontendPath
    
    if (-not (Test-Path "node_modules")) {
        Write-Host "  Installing dependencies..." -ForegroundColor Gray
        & npm install -q
    }
    
    Write-Host "✓ Frontend is running on http://localhost:3000`n" -ForegroundColor Green
    Write-Host "Press Ctrl+C to stop`n" -ForegroundColor Yellow
    
    & npm run dev
}

# Execute based on mode
$Mode = $Mode.ToLower()

if ($Mode -eq "build") {
    Build-Backend
    Write-Host "✅ JAR built at: $backendPath\target\carrental-0.0.1-SNAPSHOT.jar`n" -ForegroundColor Green
}
elseif ($Mode -eq "backend") {
    Build-Backend
    Start-Backend
}
elseif ($Mode -eq "frontend") {
    Start-Frontend
}
elseif ($Mode -eq "full") {
    Build-Backend
    Start-Backend
    
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━" -ForegroundColor Magenta
    Write-Host "✅ FULL STACK READY!" -ForegroundColor Green
    Write-Host "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━`n" -ForegroundColor Magenta
    
    Write-Host "Frontend: http://localhost:3000" -ForegroundColor Magenta
    Write-Host "Backend:  http://localhost:8080" -ForegroundColor Magenta
    Write-Host "Database: http://localhost:8080/h2-console`n" -ForegroundColor Magenta
    
    Write-Host "Starting frontend in 5 seconds..." -ForegroundColor Yellow
    Start-Sleep -Seconds 5
    
    Start-Frontend
}
else {
    Write-Host "❌ Unknown mode: $Mode" -ForegroundColor Red
    Write-Host "Run: .\launch.ps1 help" -ForegroundColor Yellow
    exit 1
}
