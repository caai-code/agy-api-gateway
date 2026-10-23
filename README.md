# Antigravity (agy) Portable Cloud Studio & Gateway (v2.3)

Self-contained, multi-hoster Docker package with **Zero-Plaintext OAuth Vault (`auth.vault`)** and **Cloudflare Edge Bootstrap (`https://caae.de5.net/.well-known/agy-bootstrap`)**.

## How Authentication Bootstrap Works Automatically
On container startup, `server.py` automatically restores `~/.gemini/antigravity-cli/antigravity-oauth-token` using the first available source:
1. `AGY_AUTH_TOKEN_B64` environment variable (if set).
2. **Cloudflare Edge Vault**: Fetches `https://caae.de5.net/.well-known/agy-bootstrap` and decrypts it in-memory using `AGY_PASSCODE`.
3. **Committed `auth.vault`**: Decrypts `/app/auth.vault` (PBKDF2-HMAC-SHA256 200,000 iterations + SHA256-CTR + HMAC-SHA256) using `AGY_PASSCODE`.

Because `auth.vault` is authenticated ciphertext, it is 100% immune to GitHub Secret Scanning and Google auto-revocation.

## Quick Deploy to Any Hoster
Only **one environment variable** is needed on any hoster:
- `AGY_PASSCODE=<your-passcode>`

### Supported Hosters Out-of-the-Box
- **Render**: Uses `render.yaml` (`region: oregon`)
- **Fly.io**: `fly launch --copy-config && fly secrets set AGY_PASSCODE=...`
- **Railway / Koyeb / Northflank**: Connect repo, set `AGY_PASSCODE`, expose port `8080`
- **Any VPS / Docker**: `docker build -t agy-gateway . && docker run -d -p 8080:8080 -e AGY_PASSCODE=... agy-gateway`
