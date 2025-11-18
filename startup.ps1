# Car Rental System - Full Stack Startup Script
# Runs both backend (Java/Spring Boot) and frontend (React/Vite)

param(
    [Parameter(Mandatory=$false)]
    [ValidateSet("backend", "frontend", "both", "help")]
    [string]$Target = "help"
)

function Show-Banner {
    Write-Host ""
    Write-Host "╔════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║   🚗 CAR RENTAL SYSTEM - Full Stack Startup           ║" -ForegroundColor Cyan
    Write-Host "╚════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""
}

function Show-Help {
    Show-Banner
    Write-Host "USAGE:" -ForegroundColor Yellow
    Write-Host "  .\startup.ps1 [backend|frontend|both|help]" -ForegroundColor Green
    Write-Host ""
    Write-Host "OPTIONS:" -ForegroundColor Yellow
    Write-Host "  backend    - Start only Spring Boot backend on port 8080" -ForegroundColor Green
    Write-Host "  frontend   - Start only React frontend on port 3000" -ForegroundColor Green
    Write-Host "  both       - Start both backend and frontend (recommended)" -ForegroundColor Green
    Write-Host "  help       - Show this help message" -ForegroundColor Green
    Write-Host ""
    Write-Host "EXAMPLES:" -ForegroundColor Yellow
    Write-Host "  .\startup.ps1 backend         # Backend only" -ForegroundColor Cyan
    Write-Host "  .\startup.ps1 frontend        # Frontend only" -ForegroundColor Cyan
    Write-Host "  .\startup.ps1 both            # Full stack" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "URLS:" -ForegroundColor Yellow
    Write-Host "  Frontend:   http://localhost:3000" -ForegroundColor Magenta
    Write-Host "  Backend:    http://localhost:8080" -ForegroundColor Magenta
    Write-Host "  Database:   http://localhost:8080/h2-console" -ForegroundColor Magenta
    Write-Host ""
}

function Start-Backend {
    Show-Banner
    Write-Host "🔷 Starting Spring Boot Backend..." -ForegroundColor Yellow
    Write-Host ""
    
    $backendPath = "d:\PROJECTS\car_manager\carRENTALsystem\CarRentalSystem"
    
    # Check if path exists
    if (!(Test-Path $backendPath)) {
        Write-Host "❌ Backend path not found: $backendPath" -ForegroundColor Red
        return
    }
    
    try {
        # Stop any existing Java processes
        Get-Process -Name java -ErrorAction SilentlyContinue | ForEach-Object {
            Write-Host "⚠️  Stopping existing Java process (PID: $($_.Id))" -ForegroundColor Yellow
            Stop-Process -Id $_.Id -Force -ErrorAction SilentlyContinue
        }
        Start-Sleep -Seconds 2
        
        # Build backend
        Write-Host "🔨 Building backend..." -ForegroundColor Cyan
        Set-Location $backendPath
        & mvn clean package -DskipTests -q
        
        if ($LASTEXITCODE -ne 0) {
            Write-Host "❌ Build failed!" -ForegroundColor Red
            return
        }
        
        Write-Host "✓ Build successful" -ForegroundColor Green
        Write-Host ""
        
        # Start application
        Write-Host "🚀 Starting application..." -ForegroundColor Green
        $jarPath = "$backendPath\target\carrental-0.0.1-SNAPSHOT.jar"
        
        if (!(Test-Path $jarPath)) {
            Write-Host "❌ JAR file not found: $jarPath" -ForegroundColor Red
            return
        }
        
        Write-Host "📦 JAR: $jarPath" -ForegroundColor Gray
        Write-Host ""
        
        # Start in a new window using Start-Process
        $process = Start-Process -NoNewWindow -FilePath "java" -ArgumentList "-jar", "`"$jarPath`"" -PassThru
        
        Write-Host "✓ Backend started (PID: $($process.Id))" -ForegroundColor Green
        Write-Host ""
        Write-Host "⏳ Waiting for server to start..." -ForegroundColor Cyan
        Start-Sleep -Seconds 8
        
        # Check if running
        try {
            $response = Invoke-WebRequest -Uri "http://localhost:8080/" -UseBasicParsing -TimeoutSec 3 -ErrorAction Stop
            Write-Host "✅ Backend is running and responding!" -ForegroundColor Green
            Write-Host "   Status: $($response.StatusCode) OK" -ForegroundColor Green
            Write-Host ""
            Write-Host "🌐 Backend URL: http://localhost:8080" -ForegroundColor Magenta
            Write-Host "🗄️  Database:   http://localhost:8080/h2-console" -ForegroundColor Magenta
        } catch {
            Write-Host "⚠️  Could not verify backend connection" -ForegroundColor Yellow
        }
    } catch {
        Write-Host "❌ Error: $_" -ForegroundColor Red
    }
}

function Start-Frontend {
    Show-Banner
    Write-Host "🔵 Starting React Frontend..." -ForegroundColor Yellow
    Write-Host ""
    
    $frontendPath = "d:\PROJECTS\car_manager\carRENTALsystem\frontend"
    
    # Check if path exists
    if (!(Test-Path $frontendPath)) {
        Write-Host "❌ Frontend path not found: $frontendPath" -ForegroundColor Red
        return
    }
    
    try {
        Set-Location $frontendPath
        
        # Verify dependencies are installed
        if (!(Test-Path "$frontendPath\node_modules")) {
            Write-Host "📦 Installing dependencies..." -ForegroundColor Cyan
            npm install
            if ($LASTEXITCODE -ne 0) {
                Write-Host "❌ npm install failed!" -ForegroundColor Red
                return
            }
        }
        
        Write-Host "✓ Dependencies ready" -ForegroundColor Green
        Write-Host ""
        Write-Host "🚀 Starting Vite development server..." -ForegroundColor Green
        Write-Host ""
        
        # Start dev server (runs in foreground)
        npm run dev
    } catch {
        Write-Host "❌ Error: $_" -ForegroundColor Red
    }
}

function Start-Both {
    Show-Banner
    
    Write-Host "📌 Starting full stack setup..." -ForegroundColor Yellow
    Write-Host ""
    
    Write-Host "You will need TWO terminal windows:" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "TERMINAL 1 - Backend:" -ForegroundColor Yellow
    Write-Host "  Run: .\startup.ps1 backend" -ForegroundColor Green
    Write-Host ""
    Write-Host "TERMINAL 2 - Frontend:" -ForegroundColor Yellow
    Write-Host "  Run: .\startup.ps1 frontend" -ForegroundColor Green
    Write-Host ""
    Write-Host "Then open:" -ForegroundColor Cyan
    Write-Host "  Frontend: http://localhost:3000" -ForegroundColor Magenta
    Write-Host "  Backend:  http://localhost:8080" -ForegroundColor Magenta
    Write-Host ""
    Write-Host "Alternatively, you can run them separately in different terminals:" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "PowerShell 1:" -ForegroundColor Cyan
    Write-Host "  cd d:\PROJECTS\car_manager\carRENTALsystem" -ForegroundColor Green
    Write-Host "  .\startup.ps1 backend" -ForegroundColor Green
    Write-Host ""
    Write-Host "PowerShell 2:" -ForegroundColor Cyan
    Write-Host "  cd d:\PROJECTS\car_manager\carRENTALsystem" -ForegroundColor Green
    Write-Host "  .\startup.ps1 frontend" -ForegroundColor Green
    Write-Host ""
}

# Main logic
switch ($Target.ToLower()) {
    "backend" { Start-Backend }
    "frontend" { Start-Frontend }
    "both" { Start-Both }
    default { Show-Help }
}
