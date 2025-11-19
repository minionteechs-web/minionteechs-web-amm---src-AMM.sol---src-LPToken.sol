#!/bin/bash

# Installation script for development environment

echo "🚀 Installing Minionteechs AMM development environment..."

# Check prerequisites
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js 18+ from https://nodejs.org/"
    exit 1
fi

if ! command -v git &> /dev/null; then
    echo "❌ Git is not installed. Please install Git from https://git-scm.com/"
    exit 1
fi

echo "✅ Node.js version: $(node --version)"
echo "✅ npm version: $(npm --version)"

# Install root dependencies
echo ""
echo "📦 Installing root dependencies..."
npm install

# Install backend dependencies
echo ""
echo "📦 Installing backend dependencies..."
cd backend
npm install
cd ..

# Install frontend dependencies
echo ""
echo "📦 Installing frontend dependencies..."
cd frontend
npm install
cd ..

# Check for Foundry
echo ""
if ! command -v forge &> /dev/null; then
    echo "⚠️  Foundry is not installed."
    echo "Install with: curl -L https://foundry.paradigm.xyz | bash"
else
    echo "✅ Foundry is installed"
    forge --version
fi

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    echo ""
    echo "📝 Creating .env file from .env.example..."
    cp .env.example .env
    echo "⚠️  Please edit .env with your configuration"
fi

echo ""
echo "✅ Installation complete!"
echo ""
echo "📖 Next steps:"
echo "1. Edit .env with your configuration"
echo "2. Run 'npm run dev' to start all services"
echo "3. Check README.md for more information"
