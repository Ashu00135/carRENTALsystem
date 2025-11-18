@echo off
REM Car Rental Frontend - Setup Script for Windows
REM This script sets up the React frontend with all dependencies

echo.
echo 🚀 Car Rental System - Frontend Setup
echo ======================================
echo.

REM Check if Node.js is installed
node --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Node.js is not installed. Please install from https://nodejs.org/
    pause
    exit /b 1
)

echo ✓ Node.js is installed: 
node --version

REM Check if npm is installed
npm --version >nul 2>&1
if errorlevel 1 (
    echo ❌ npm is not installed.
    pause
    exit /b 1
)

echo ✓ npm is installed: 
npm --version

echo.
echo 📦 Installing dependencies...
echo.

call npm install

if %errorlevel% equ 0 (
    echo.
    echo ✅ Setup Complete!
    echo.
    echo Available Commands:
    echo   npm run dev      - Start development server (http://localhost:3000^)
    echo   npm run build    - Build for production
    echo   npm run preview  - Preview production build
    echo.
    echo 📍 Make sure the backend is running on http://localhost:8080
    echo.
    echo Start development:
    echo   npm run dev
    echo.
) else (
    echo ❌ Installation failed. Please check the errors above.
    exit /b 1
)

pause
