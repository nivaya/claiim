# CLAIIM -- AI Agent Identity Control Plane

**Govern AI agents before they act.**

CLAIIM gives every AI agent a governed identity, binds it to a human accountability anchor, checks every action against policy, and records every ALLOW or DENY in Chron.

- Website: [claiim.io](https://claiim.io)
- Docs: [claiim.io/docs/install](https://claiim.io/docs/install)
- Contact: [hello@nivaya.io](mailto:hello@nivaya.io)

---

## This Repository

This is the **public distribution repository** for CLAIIM. It contains:

- `compose.yml` -- Docker Compose stack for the Evaluation Preview
- `.env.example` -- required environment variables
- `rehearsal.sh` -- smoke-test script to verify your install

CLAIIM is proprietary software. This repository does not contain source code. Runtime images are distributed as signed containers and pulled automatically by Docker Compose.

---

## Image Access

Runtime container images are gated during the controlled preview rollout. Before running `docker compose up -d`, you need pull credentials.

**Request access:** email [hello@nivaya.io](mailto:hello@nivaya.io) or visit [claiim.io/contact](https://claiim.io/contact).

You will receive a personal access token to authenticate against the container registry:

```bash
docker login ghcr.io -u YOUR_GITHUB_USERNAME --password YOUR_TOKEN
```

`docker compose up -d` will fail with an authentication error without this step.

---

## Quick Start (Evaluation Preview)

**Prerequisites:** Docker, Docker Compose v2, pull credentials (see above).

```bash
git clone https://github.com/nivaya/claiim
cd claiim
cp .env.example .env
```

Open `.env` and set `TOKEN_SECRET` to a random 32-character string:

```bash
# Generate a secret:
openssl rand -hex 32
```

Then start the stack:

```bash
docker compose up -d
```

Verify everything is healthy:

```bash
bash rehearsal.sh
```

Open [http://localhost:3001](http://localhost:3001) to access the admin UI.

**Full install guide:** [claiim.io/docs/install](https://claiim.io/docs/install)

---

## What the Stack Includes

| Service | Port | Description |
|---------|------|-------------|
| claiim-api | 8181 | Gate API and Chron writer |
| claiim-ui | 3001 | Admin UI |
| postgres | (internal) | Bundled PostgreSQL for evaluation |

The bundled PostgreSQL is for evaluation convenience only. Before going into production, set `DATABASE_URL` in `.env` to your own PostgreSQL instance.

---

## Tiers

| Tier | Status | Notes |
|------|--------|-------|
| Evaluation Preview | Available now | Docker Compose, single node |
| Professional | In development | Kubernetes, HA, SAML/OIDC |
| Sovereign | In development | Air-gap, mTLS, signed bundles |

---

## License

CLAIIM is proprietary software. Use of CLAIIM is governed by the [CLAIIM Evaluation License](./LICENSE).

Evaluation Preview is free for internal evaluation. Production use requires a commercial license. Contact [hello@nivaya.io](mailto:hello@nivaya.io) for licensing.

---

A product by [Nivaya Technologies](https://nivaya.io).
