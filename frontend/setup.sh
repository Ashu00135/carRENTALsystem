#!/bin/bash

# Car Rental Frontend - Setup Script
# This script sets up the React frontend with all dependencies

echo "🚀 Car Rental System - Frontend Setup"
echo "======================================"
echo ""

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js 16+ from https://nodejs.org/"
    exit 1
fi

echo "✓ Node.js $(node --version) is installed"

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "❌ npm is not installed."
    exit 1
fi

echo "✓ npm $(npm --version) is installed"
echo ""

# Navigate to frontend directory
cd "$(dirname "$0")" || exit

echo "📦 Installing dependencies..."
npm install

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ Setup Complete!"
    echo ""
    echo "Available Commands:"
    echo "  npm run dev      - Start development server (http://localhost:3000)"
    echo "  npm run build    - Build for production"
    echo "  npm run preview  - Preview production build"
    echo ""
    echo "📍 Make sure the backend is running on http://localhost:8080"
    echo ""
    echo "Start development:"
    echo "  npm run dev"
else
    echo "❌ Installation failed. Please check the errors above."
    exit 1
fi
