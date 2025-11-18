@echo off
REM Car Rental System - Simple Launcher
REM Build and run the application

setlocal enabledelayedexpansion

echo.
echo ╔════════════════════════════════════════════╗
echo ║  ^*🚗 CAR RENTAL SYSTEM - LAUNCHER        ║
echo ╚════════════════════════════════════════════╝
echo.

set MODE=%1
if "!MODE!"=="" set MODE=full
if "!MODE!"=="help" goto :help
if "!MODE!"=="full" goto :full
if "!MODE!"=="backend" goto :backend
if "!MODE!"=="frontend" goto :frontend
if "!MODE!"=="build" goto :build

echo ❌ Unknown mode: !MODE!
echo Run: run.bat help
exit /b 1

:help
echo USAGE: run.bat [mode]
echo.
echo MODES:
echo   full       - Build and run backend + frontend
echo   backend    - Build and run backend only
echo   frontend   - Run frontend only
echo   build      - Build backend JAR only
echo.
exit /b 0

:build
echo 🔨 Building backend...
cd /d "d:\PROJECTS\car_manager\carRENTALsystem\CarRentalSystem"
call mvn clean package -DskipTests -q
echo ✓ Build complete
exit /b 0

:backend
echo 🔨 Building backend...
cd /d "d:\PROJECTS\car_manager\carRENTALsystem\CarRentalSystem"
call mvn clean package -DskipTests -q
echo ✓ Build complete
echo.
echo 🚀 Starting backend...
taskkill /f /im java.exe >nul 2>&1
timeout /t 2 >nul
start "Car Rental Backend" java -jar target\carrental-0.0.1-SNAPSHOT.jar
echo ✓ Backend started
pause
exit /b 0

:frontend
echo 🎨 Starting frontend...
cd /d "d:\PROJECTS\car_manager\carRENTALsystem\frontend"
if not exist "node_modules" (
    echo Installing dependencies...
    call npm install -q
)
echo ✓ Frontend running on http://localhost:3000
call npm run dev
exit /b 0

:full
echo 🔨 Building backend...
cd /d "d:\PROJECTS\car_manager\carRENTALsystem\CarRentalSystem"
call mvn clean package -DskipTests -q
if !errorlevel! neq 0 (
    echo ❌ Build failed!
    exit /b 1
)
echo ✓ Build complete
echo.
echo 🚀 Starting backend...
taskkill /f /im java.exe >nul 2>&1
timeout /t 2 >nul
start "Car Rental Backend" java -jar target\carrental-0.0.1-SNAPSHOT.jar
echo ✓ Backend started
echo.
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo ✅ BACKEND READY!
echo ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
echo.
echo Frontend: http://localhost:3000
echo Backend:  http://localhost:8080
echo Database: http://localhost:8080/h2-console
echo.
echo Waiting 8 seconds before starting frontend...
timeout /t 8 >nul
echo.
echo 🎨 Starting frontend...
cd /d "d:\PROJECTS\car_manager\carRENTALsystem\frontend"
if not exist "node_modules" (
    echo Installing dependencies...
    call npm install -q
)
call npm run dev
