# Car Rental System - PostgreSQL Setup and Start Script

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  Car Rental PostgreSQL Setup" -ForegroundColor Green
Write-Host "========================================`n" -ForegroundColor Cyan

# Check if PostgreSQL is running
Write-Host "[1/6] Checking PostgreSQL service..." -ForegroundColor Yellow
$pgService = Get-Service postgresql* -ErrorAction SilentlyContinue | Where-Object {$_.Status -eq 'Running'}
if ($pgService) {
    Write-Host "✓ PostgreSQL is running ($($pgService.Name))`n" -ForegroundColor Green
} else {
    Write-Host "✗ PostgreSQL is not running!" -ForegroundColor Red
    Write-Host "  Please start PostgreSQL service and try again.`n" -ForegroundColor Yellow
    Write-Host "  Run: Get-Service postgresql* | Start-Service`n" -ForegroundColor Cyan
    exit 1
}

# Stop existing processes
Write-Host "[2/6] Stopping existing processes..." -ForegroundColor Yellow
Get-Process java,node -ErrorAction SilentlyContinue | Stop-Process -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 3
Write-Host "✓ Processes stopped`n" -ForegroundColor Green

# Rebuild backend
Write-Host "[3/6] Rebuilding Spring Boot Backend..." -ForegroundColor Yellow
Set-Location "d:\PROJECTS\car_manager\carRENTALsystem\CarRentalSystem"
mvn clean package -DskipTests 2>&1 | Out-Null
if ($LASTEXITCODE -ne 0) {
    Write-Host "✗ Backend build failed!" -ForegroundColor Red
    Write-Host "  Run manually: mvn clean package`n" -ForegroundColor Yellow
    exit 1
}
Write-Host "✓ Backend built successfully`n" -ForegroundColor Green

# Database verification
Write-Host "[4/6] Database Configuration Check..." -ForegroundColor Yellow
Write-Host "  Database: carrental" -ForegroundColor Cyan
Write-Host "  Host: localhost:5432" -ForegroundColor Cyan
Write-Host "  Username: postgres" -ForegroundColor Cyan
Write-Host ""
$dbReady = Read-Host "Have you created the 'carrental' database in PostgreSQL? (Y/N)"
if ($dbReady -ne 'Y' -and $dbReady -ne 'y') {
    Write-Host "`n⚠️  Please create the database first:" -ForegroundColor Yellow
    Write-Host "  1. Open DBeaver" -ForegroundColor White
    Write-Host "  2. Connect to PostgreSQL" -ForegroundColor White
    Write-Host "  3. Run: CREATE DATABASE carrental;" -ForegroundColor Cyan
    Write-Host "  4. Then run this script again`n" -ForegroundColor White
    exit 0
}
Write-Host "✓ Database ready`n" -ForegroundColor Green

# Start backend
Write-Host "[5/6] Starting Backend (PostgreSQL mode)..." -ForegroundColor Yellow
$jarPath = "target\carrental-0.0.1-SNAPSHOT.jar"
Start-Process powershell -ArgumentList "-NoExit", "-Command", "Write-Host 'Starting Car Rental Backend...' -ForegroundColor Cyan; java -jar `"$jarPath`"; Write-Host 'Backend stopped' -ForegroundColor Red; pause"
Write-Host "✓ Backend starting...`n" -ForegroundColor Green
Write-Host "  Waiting 25 seconds for database tables to be created..." -ForegroundColor Yellow
Start-Sleep -Seconds 25

# Verify backend
Write-Host "  Checking backend health..." -ForegroundColor Yellow
$backendHealthy = $false
for ($i = 1; $i -le 3; $i++) {
    try {
        $response = Invoke-WebRequest -Uri "http://localhost:8080/api/health" -UseBasicParsing -TimeoutSec 5 -ErrorAction Stop
        if ($response.StatusCode -eq 200) {
            $backendHealthy = $true
            break
        }
    } catch {
        Write-Host "  Attempt $i/3: Backend still starting..." -ForegroundColor Gray
        Start-Sleep -Seconds 5
    }
}

if ($backendHealthy) {
    Write-Host "✓ Backend is healthy!`n" -ForegroundColor Green
} else {
    Write-Host "⚠️  Backend health check failed" -ForegroundColor Yellow
    Write-Host "  It may still be starting. Check the backend window.`n" -ForegroundColor Gray
}

# Start frontend
Write-Host "[6/6] Starting Frontend..." -ForegroundColor Yellow
Set-Location "d:\PROJECTS\car_manager\carRENTALsystem\frontend"
Start-Process powershell -ArgumentList "-NoExit", "-Command", "Write-Host 'Starting Car Rental Frontend...' -ForegroundColor Cyan; npm run dev; Write-Host 'Frontend stopped' -ForegroundColor Red; pause"
Write-Host "✓ Frontend starting...`n" -ForegroundColor Green
Start-Sleep -Seconds 5

# Final status
Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "           SETUP COMPLETE" -ForegroundColor Green
Write-Host "========================================`n" -ForegroundColor Cyan

Write-Host "🌐 Application URLs:" -ForegroundColor White
Write-Host "   Frontend:  http://localhost:3000" -ForegroundColor Cyan
Write-Host "   Backend:   http://localhost:8080" -ForegroundColor Cyan
Write-Host "   API Health: http://localhost:8080/api/health`n" -ForegroundColor Cyan

Write-Host "🗄️  Database:" -ForegroundColor White
Write-Host "   Database:  carrental" -ForegroundColor Cyan
Write-Host "   Host:      localhost:5432" -ForegroundColor Cyan
Write-Host "   Schema:    public`n" -ForegroundColor Cyan

Write-Host "✅ What to do next:" -ForegroundColor White
Write-Host "   1. Open DBeaver and refresh the 'carrental' database" -ForegroundColor Yellow
Write-Host "   2. You should see tables: car, app_user, rental" -ForegroundColor Yellow
Write-Host "   3. Open http://localhost:3000 in your browser" -ForegroundColor Yellow
Write-Host "   4. Try adding users, cars, and creating rentals" -ForegroundColor Yellow
Write-Host "   5. Check DBeaver to see data being saved in real-time!`n" -ForegroundColor Yellow

Write-Host "📝 Troubleshooting:" -ForegroundColor White
Write-Host "   - If backend fails, check PostgreSQL credentials in application.properties" -ForegroundColor Gray
Write-Host "   - If tables don't appear, check backend logs for 'Hibernate: create table'" -ForegroundColor Gray
Write-Host "   - See POSTGRESQL_SETUP.md for detailed help`n" -ForegroundColor Gray

Write-Host "Press any key to exit..." -ForegroundColor DarkGray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
