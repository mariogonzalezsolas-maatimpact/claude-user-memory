# WSTG-v42-CRYP — Cryptography

Tests in this category focus on the correct use of cryptography: TLS configuration, encryption algorithms, and key management.

---

## WSTG-v42-CRYP-01 — Testing for Weak Transport Layer Security

**Objective:** Verify TLS is configured according to current best practices.

**What to check:**
- Only TLS 1.2 and TLS 1.3 are supported (SSLv2, SSLv3, TLS 1.0, TLS 1.1 disabled)
- Cipher suites exclude RC4, 3DES, NULL, EXPORT, anonymous ciphers
- Perfect Forward Secrecy (ECDHE cipher suites)
- Strong certificate (RSA 2048+ or ECDSA P-256+)
- Certificate is valid, not expired, and matches the hostname
- HSTS header present (see CONF-07)
- OCSP stapling enabled
- Test with `testssl.sh`, Qualys SSL Labs, or similar
- Target grade: A or A+ on SSL Labs

**Pass criteria:** Qualys SSL Labs grade A or better. No deprecated protocols or ciphers.

**Severity if failing:** High.

---

## WSTG-v42-CRYP-02 — Testing for Padding Oracle

**Objective:** Verify the application is not vulnerable to padding oracle attacks against its cryptographic implementation.

**What to check:**
- CBC mode ciphers are combined with MAC (encrypt-then-MAC) or use AEAD (GCM)
- Error responses don't distinguish "padding error" from "MAC error"
- Libraries used for encryption are up to date
- Custom cryptography is avoided
- Test error handling for symmetric encryption operations

**Pass criteria:** No distinguishable error conditions that reveal padding validity. Prefer AEAD modes (AES-GCM, ChaCha20-Poly1305).

**Severity if failing:** High.

---

## WSTG-v42-CRYP-03 — Testing for Sensitive Information Sent via Unencrypted Channels

**Objective:** Verify sensitive data is never transmitted over unencrypted channels.

**What to check:**
- No sensitive data in HTTP requests (always HTTPS)
- No sensitive data in plaintext emails
- No sensitive data in SMS unless necessary
- Backup channels use encryption
- Webhooks to third parties use HTTPS
- Internal service-to-service communication is encrypted (mTLS, TLS, or equivalent)
- Message queues transmit encrypted payloads for sensitive data

**Pass criteria:** All sensitive data channels use encryption in transit.

**Severity if failing:** High.

---

## WSTG-v42-CRYP-04 — Testing for Weak Encryption

**Objective:** Verify the application uses strong, modern cryptographic algorithms.

**What to check:**
- No MD5, SHA1 for security-sensitive hashing (fingerprints, integrity)
- Password hashing uses bcrypt, argon2, scrypt, or PBKDF2 with sufficient iterations
- Symmetric encryption uses AES-GCM, ChaCha20-Poly1305 (AEAD)
- Asymmetric encryption uses RSA 2048+, ECDSA P-256+, Ed25519
- No custom/homegrown cryptography
- Keys are generated from strong random sources
- Key rotation policy exists for long-lived keys
- No hardcoded keys or IVs in source code
- IVs/nonces are unique per encryption operation

**Pass criteria:** All cryptographic operations use current best-practice algorithms and parameters.

**Severity if failing:** High to Critical depending on what's encrypted.
