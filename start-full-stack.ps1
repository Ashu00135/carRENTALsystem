# Car Rental System - Full Stack Startup Script

Write-Host "`nCar Rental System - Full Stack Startup`n" -ForegroundColor Green

# Stop any existing processes
Write-Host "Stopping existing processes..." -ForegroundColor Yellow
Get-Process java -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
Get-Process node -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

# Start Backend
Write-Host "`nStarting Backend (Spring Boot on port 8080)..." -ForegroundColor Cyan
Push-Location "d:\PROJECTS\car_manager\carRENTALsystem"
$jarPath = "CarRentalSystem\target\carrental-0.0.1-SNAPSHOT.jar"
$backendProcess = Start-Process -NoNewWindow -FilePath "java" -ArgumentList "-jar", "`"$jarPath`"" -PassThru
Write-Host "Backend started (PID: $($backendProcess.Id))" -ForegroundColor Green
Start-Sleep -Seconds 12

# Start Frontend
Write-Host "`nStarting Frontend (Vite on port 3000)..." -ForegroundColor Cyan
Push-Location "d:\PROJECTS\car_manager\carRENTALsystem\frontend"
$frontendProcess = Start-Process -NoNewWindow -FilePath "npm" -ArgumentList "run", "dev" -PassThru
Write-Host "Frontend started (PID: $($frontendProcess.Id))" -ForegroundColor Green
Start-Sleep -Seconds 5

# Verify services
Write-Host "`nVerifying services..." -ForegroundColor Cyan

$backendOK = $false
$frontendOK = $false

try {
    $response = Invoke-WebRequest -Uri "http://localhost:8080/api/health" -UseBasicParsing -ErrorAction SilentlyContinue -TimeoutSec 5
    if ($response.StatusCode -eq 200) {
        $backendOK = $true
    }
} catch {
    $backendOK = $false
}

try {
    $response = Invoke-WebRequest -Uri "http://localhost:3000" -UseBasicParsing -ErrorAction SilentlyContinue -TimeoutSec 5
    if ($response.StatusCode -eq 200) {
        $frontendOK = $true
    }
} catch {
    $frontendOK = $false
}

if ($backendOK) {
    Write-Host "Backend responding (port 8080)" -ForegroundColor Green
    try {
        $cars = Invoke-WebRequest -Uri "http://localhost:8080/api/cars" -UseBasicParsing -ErrorAction SilentlyContinue | ConvertFrom-Json
        Write-Host "$($cars.Count) cars loaded" -ForegroundColor Cyan
    } catch {
        # Silent
    }
} else {
    Write-Host "Backend not responding yet" -ForegroundColor Yellow
}

if ($frontendOK) {
    Write-Host "Frontend responding (port 3000)" -ForegroundColor Green
} else {
    Write-Host "Frontend still starting..." -ForegroundColor Yellow
}

Write-Host "`nSYSTEM READY" -ForegroundColor Green
Write-Host "Frontend:  http://localhost:3000" -ForegroundColor Magenta
Write-Host "Backend:   http://localhost:8080" -ForegroundColor Magenta
Write-Host "Database:  http://localhost:8080/h2-console`n" -ForegroundColor Magenta

Pop-Location
Pop-Location
