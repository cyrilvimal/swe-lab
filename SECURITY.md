# Security

## Reporting a Security Issue

Please do not publish sensitive information, credentials, private keys, tokens or exploitable details in a public issue.

For sensitive issues, use a private communication channel associated with the repository owner.

## Repository Rules

Never commit:

- Passwords
- API keys
- Access tokens
- Private keys
- Production connection strings
- Certificates containing private material
- Cloud credentials
- Personal or customer data

Use placeholders or environment variables instead.

Example:

```text
DATABASE_CONNECTION_STRING=<set-in-environment>
API_TOKEN=<set-in-environment>
```

If a secret is accidentally committed, rotate/revoke it immediately. Removing the file in a later commit is not sufficient because the secret may remain in Git history.
