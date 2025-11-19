# Contributing to Minionteechs Web AMM

We appreciate your interest in contributing! Please follow these guidelines.

## Code of Conduct

Please review our [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) to understand expected behavior.

## Getting Started

1. Fork the repository
2. Clone your fork: `git clone https://github.com/your-username/minionteechs-web-amm.git`
3. Create a feature branch: `git checkout -b feature/your-feature`
4. Install dependencies: `npm install`

## Development Setup

### Foundry Contracts
```bash
# Install Foundry
curl -L https://foundry.paradigm.xyz | bash
foundryup

# Run tests
forge test

# Generate gas reports
forge snapshot
```

### Backend
```bash
cd backend
npm install
npm run dev
```

### Frontend
```bash
cd frontend
npm install
npm run dev
```

## Commit Guidelines

Use conventional commits:
- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation
- `test:` Testing
- `refactor:` Code refactoring
- `style:` Code style changes
- `chore:` Build, dependencies, etc.

Example: `feat: add swap functionality to AMM`

## Pull Request Process

1. Update documentation
2. Add tests for new features
3. Ensure all tests pass: `npm run test`
4. Submit PR with clear description
5. Wait for review from maintainers

## Smart Contract Development

- Follow Solidity style guide
- Use proper access control
- Include comprehensive NatSpec comments
- Test edge cases
- Consider gas optimization

## Testing Requirements

- Unit tests required for all features
- Minimum 80% code coverage
- Integration tests for contract interactions
- Invariant tests for AMM mechanics

## Questions?

Open a discussion or issue with the `question` label.
