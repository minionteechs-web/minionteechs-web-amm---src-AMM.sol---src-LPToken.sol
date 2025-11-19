# Security Policy

## Reporting a Vulnerability

If you discover a security vulnerability, please email minionteechs@gmail.com instead of using the issue tracker.

Include:
- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Suggested fix (if any)

## Security Considerations

### Smart Contracts

- All contracts have been tested with unit and invariant tests
- We recommend professional audits before mainnet deployment
- Follow these best practices:
  - Use safe math operations (no overflow/underflow)
  - Implement proper access control
  - Validate all inputs
  - Use checks-effects-interactions pattern

### Backend

- All endpoints validate input
- Environment variables for sensitive data
- CORS restrictions applied
- Helmet.js for security headers
- Request rate limiting recommended

### Frontend

- No sensitive data stored in localStorage
- HTTPS only in production
- Content Security Policy headers
- XSS protection enabled

## Supported Versions

| Version | Supported |
|---------|-----------|
| 1.0.x   | ✅ Yes    |

## Updates

Security updates are released as soon as vulnerabilities are fixed. Always keep dependencies updated.

```bash
npm audit
npm audit fix
```

## Third-Party Dependencies

We use well-maintained, audited packages:
- ethers.js: Industry standard Web3 library
- Express.js: Widely-used, secure framework
- React: Large community and security support

Check for vulnerabilities regularly with `npm audit`.
