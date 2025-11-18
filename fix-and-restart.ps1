# Car Rental System - Fix and Restart Script
# This script stops existing services, rebuilds, and restarts the application

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  Car Rental System - Fix & Restart" -ForegroundColor Green
Write-Host "========================================`n" -ForegroundColor Cyan

# Step 1: Stop all running instances
Write-Host "[1/5] Stopping existing processes..." -ForegroundColor Yellow
Get-Process java -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
Get-Process node -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 3
Write-Host "✓ Processes stopped`n" -ForegroundColor Green

# Step 2: Rebuild Backend
Write-Host "[2/5] Rebuilding Spring Boot Backend..." -ForegroundColor Yellow
Set-Location "d:\PROJECTS\car_manager\carRENTALsystem\CarRentalSystem"
mvn clean package -DskipTests
if ($LASTEXITCODE -ne 0) {
    Write-Host "✗ Backend build failed!" -ForegroundColor Red
    exit 1
}
Write-Host "✓ Backend built successfully`n" -ForegroundColor Green

# Step 3: Start Backend
Write-Host "[3/5] Starting Backend (Spring Boot on port 8080)..." -ForegroundColor Yellow
$jarPath = "target\carrental-0.0.1-SNAPSHOT.jar"
Start-Process powershell -ArgumentList "-NoExit", "-Command", "java -jar `"$jarPath`""
Write-Host "✓ Backend starting... (waiting 15 seconds)`n" -ForegroundColor Green
Start-Sleep -Seconds 15

# Step 4: Verify Backend
Write-Host "[4/5] Verifying Backend..." -ForegroundColor Yellow
try {
    $response = Invoke-WebRequest -Uri "http://localhost:8080/api/health" -UseBasicParsing -TimeoutSec 5
    if ($response.StatusCode -eq 200) {
        Write-Host "✓ Backend is healthy (200 OK)`n" -ForegroundColor Green
    }
} catch {
    Write-Host "✗ Backend health check failed: $_" -ForegroundColor Red
    Write-Host "  Backend may still be starting up. Check the backend window.`n" -ForegroundColor Yellow
}

# Step 5: Start Frontend
Write-Host "[5/5] Starting Frontend (Vite on port 3000)..." -ForegroundColor Yellow
Set-Location "d:\PROJECTS\car_manager\carRENTALsystem\frontend"
Start-Process powershell -ArgumentList "-NoExit", "-Command", "npm run dev"
Write-Host "✓ Frontend starting...`n" -ForegroundColor Green
Start-Sleep -Seconds 5

# Final Status
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "           STARTUP COMPLETE" -ForegroundColor Green
Write-Host "========================================`n" -ForegroundColor Cyan

Write-Host "Services:" -ForegroundColor White
Write-Host "  Backend:  http://localhost:8080" -ForegroundColor Cyan
Write-Host "  Frontend: http://localhost:3000" -ForegroundColor Cyan
Write-Host "  H2 Console: http://localhost:8080/h2-console`n" -ForegroundColor Cyan

Write-Host "Fixes Applied:" -ForegroundColor White
Write-Host "  ✓ Fixed double /api prefix in createRental()" -ForegroundColor Green
Write-Host "  ✓ Fixed Vite proxy configuration" -ForegroundColor Green
Write-Host "  ✓ Backend and Frontend restarted`n" -ForegroundColor Green

Write-Host "Next Steps:" -ForegroundColor White
Write-Host "  1. Open http://localhost:3000 in your browser" -ForegroundColor Yellow
Write-Host "  2. Try renting a car - it should work now!" -ForegroundColor Yellow
Write-Host "  3. If issues persist, check the backend/frontend windows for errors`n" -ForegroundColor Yellow

Write-Host "Press any key to exit..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
