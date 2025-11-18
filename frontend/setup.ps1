# Car Rental Frontend - Setup PowerShell Script
# This script sets up the React frontend in an isolated Node environment

function Write-Status {
    param([string]$Message, [string]$Status = "info")
    $colors = @{
        "success" = "Green"
        "error" = "Red"
        "warning" = "Yellow"
        "info" = "Cyan"
    }
    Write-Host $Message -ForegroundColor $colors[$Status]
}

Write-Host ""
Write-Status "🚀 Car Rental System - Frontend Setup" "info"
Write-Status "======================================" "info"
Write-Host ""

# Check if Node.js is installed
try {
    $nodeVersion = node --version 2>$null
    Write-Status "✓ Node.js $nodeVersion is installed" "success"
} catch {
    Write-Status "❌ Node.js is not installed. Please install from https://nodejs.org/" "error"
    exit 1
}

# Check if npm is installed
try {
    $npmVersion = npm --version 2>$null
    Write-Status "✓ npm $npmVersion is installed" "success"
} catch {
    Write-Status "❌ npm is not installed" "error"
    exit 1
}

Write-Host ""

# Get script location
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptPath

Write-Status "📍 Working directory: $(Get-Location)" "info"
Write-Host ""

# Check if node_modules exists
if (Test-Path "node_modules") {
    Write-Status "⚠️  node_modules already exists. Skipping installation." "warning"
    Write-Host ""
    Write-Status "Use 'npm update' to update packages" "info"
} else {
    Write-Status "📦 Installing dependencies..." "info"
    Write-Host ""
    
    # Install dependencies
    npm install
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Status "✅ Setup Complete!" "success"
    } else {
        Write-Host ""
        Write-Status "❌ Installation failed. Please check the errors above." "error"
        exit 1
    }
}

Write-Host ""
Write-Status "Available Commands:" "info"
Write-Host "  npm run dev      - Start development server (http://localhost:3000)" -ForegroundColor Gray
Write-Host "  npm run build    - Build for production" -ForegroundColor Gray
Write-Host "  npm run preview  - Preview production build" -ForegroundColor Gray
Write-Host ""

Write-Status "📍 Backend must be running on http://localhost:8080" "warning"
Write-Host ""

Write-Status "Start development server:" "info"
Write-Host "  cd $scriptPath" -ForegroundColor Gray
Write-Host "  npm run dev" -ForegroundColor Gray
Write-Host ""
