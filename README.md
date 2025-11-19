# Minionteechs Web AMM

![License](https://img.shields.io/badge/license-MIT-blue)
![Solidity](https://img.shields.io/badge/solidity-0.8.20-blue)
![Node](https://img.shields.io/badge/node-18%2B-green)

A professional, production-ready Automated Market Maker (AMM) implementation with smart contracts, backend API, and frontend interface.

## 🎯 Features

- **Smart Contracts**: Solidity-based AMM with ERC20 support
- **Backend API**: Express.js API for contract interactions
- **Frontend UI**: React + TypeScript interface for user interactions
- **Full Testing**: Unit tests, integration tests, and invariant tests
- **CI/CD**: GitHub Actions workflows for automated testing
- **Professional Documentation**: Contributing guidelines and code of conduct

## 📁 Project Structure

```
minionteechs-web-amm/
├── src/                          # Smart contracts
│   ├── AMM.sol                   # Core AMM contract
│   ├── LPToken.sol               # Liquidity Provider token
│   └── interfaces/
│       └── IERC20.sol            # ERC20 interface
├── test/
│   ├── AMM.t.sol                 # Unit tests
│   └── Invariant.t.sol           # Invariant tests
├── script/
│   └── Deploy.s.sol              # Deployment script
├── backend/                      # Node.js/Express API
│   ├── src/
│   │   ├── index.ts              # Main server file
│   │   ├── routes/               # API endpoints
│   │   ├── controllers/          # Request handlers
│   │   ├── services/             # Business logic
│   │   └── middleware/           # Express middleware
│   ├── package.json
│   └── tsconfig.json
├── frontend/                     # React application
│   ├── src/
│   │   ├── components/           # React components
│   │   ├── pages/                # Page components
│   │   ├── hooks/                # Custom React hooks
│   │   ├── services/             # API services
│   │   ├── types/                # TypeScript types
│   │   ├── App.tsx
│   │   └── main.tsx
│   ├── index.html
│   ├── vite.config.ts
│   └── package.json
├── .github/
│   └── workflows/
│       ├── test.yml              # Test workflow
│       └── deploy.yml            # Deploy workflow
├── foundry.toml
├── package.json                  # Root scripts
├── .gitignore
├── .env.example
├── LICENSE
├── CONTRIBUTING.md
├── CODE_OF_CONDUCT.md
└── README.md
```

## 🚀 Quick Start

### Prerequisites

- Node.js >= 18
- Foundry (for smart contracts)
- Git

### Installation

```bash
# Clone the repository
git clone https://github.com/minionteechs-web/minionteechs-web-amm.git
cd minionteechs-web-amm

# Install all dependencies
npm run install:all

# Setup environment variables
cp .env.example .env
# Edit .env with your configuration
```

### Development

Start all services in development mode:

```bash
npm run dev
```

This starts:
- Frontend on `http://localhost:3000`
- Backend on `http://localhost:3001`
- Contract compilation and testing

### Individual Services

**Frontend only:**
```bash
cd frontend
npm run dev
```

**Backend only:**
```bash
cd backend
npm run dev
```

**Smart Contracts:**
```bash
forge build
forge test -vvv
```

## 🧪 Testing

### Run All Tests

```bash
npm run test
```

### Test Specific Components

```bash
# Smart contract tests
npm run test:contracts

# Backend tests
npm run test:backend

# Frontend tests
npm run test:frontend

# Coverage report
npm run test:coverage
```

## 📚 Smart Contract Documentation

### AMM.sol

Core AMM contract implementing the constant product formula (x*y=k).

**Key Functions:**
- `addLiquidity(amount0, amount1)`: Add liquidity to the pool
- `removeLiquidity(lpAmount)`: Remove liquidity from the pool
- `swap(amountIn, tokenIn)`: Swap tokens

**Events:**
- `Swap`: Emitted on token swaps
- `Liquidity`: Emitted on liquidity changes

### LPToken.sol

ERC20 token representing liquidity provider shares. Implements standard ERC20 interface with mint/burn functionality for the AMM.

## 🔌 API Endpoints

### Health Check

```bash
GET /api/health
```

### AMM Operations

```bash
# Get current reserves
GET /api/amm/reserves

# Simulate swap
POST /api/amm/simulate-swap
Body: { "amountIn": "1000", "tokenIn": "0x..." }

# Get liquidity info
GET /api/amm/liquidity-info/:address
```

## 🏗️ Building and Deployment

### Build All

```bash
npm run build
```

### Build Specific Components

```bash
# Build smart contracts
npm run build:contracts

# Build backend
npm run build:backend

# Build frontend
npm run build:frontend
```

### Deploy Smart Contracts

```bash
npm run deploy
```

Requires environment variables:
- `ETHEREUM_RPC_URL`
- `PRIVATE_KEY`

## 📋 Git Workflow

1. Create a feature branch: `git checkout -b feature/amazing-feature`
2. Make your changes
3. Run tests: `npm run test`
4. Run linter: `npm run lint`
5. Commit with conventional commits: `git commit -m 'feat: add amazing feature'`
6. Push to your fork
7. Open a Pull Request

See [CONTRIBUTING.md](CONTRIBUTING.md) for detailed guidelines.

## 🔐 Security

- All smart contracts follow Solidity best practices
- Input validation on all endpoints
- Error handling and logging implemented
- See [SECURITY.md](SECURITY.md) for security policies

## 📝 Configuration

### Environment Variables

See `.env.example` for required variables:

```bash
# Blockchain
PRIVATE_KEY=your_private_key_here
ETHEREUM_RPC_URL=https://eth.llamarpc.com
ETHERSCAN_API_KEY=your_etherscan_api_key

# Backend
BACKEND_PORT=3001
NODE_ENV=development

# Frontend
REACT_APP_API_URL=http://localhost:3001
REACT_APP_CONTRACT_ADDRESS=0x...
```

## 🔄 CI/CD

GitHub Actions workflows automatically:
- Run tests on push/PR
- Perform static analysis (Slither)
- Build contracts and applications
- Deploy on push to main

See `.github/workflows/` for configuration.

## 📦 Dependencies

### Smart Contracts
- Solidity 0.8.20
- Foundry

### Backend
- Express.js
- ethers.js
- TypeScript

### Frontend
- React 18
- TypeScript
- Vite
- wagmi (Web3 integration)

## 🤝 Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for:
- Development setup
- Commit guidelines
- PR process
- Code standards

## 📄 License

This project is licensed under the MIT License - see [LICENSE](LICENSE) file for details.

## 👥 Code of Conduct

Please review [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) for community guidelines.

## 📞 Support

- Open an issue for bug reports
- Start a discussion for questions
- Check existing issues before creating new ones

## 🎉 Acknowledgments

Built with ❤️ by Minionteechs Web

---

**Last Updated**: November 2025
