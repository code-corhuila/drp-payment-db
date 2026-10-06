# drp-payment-db

Payment schema. **Migrations only.** Engine: [`drp-infra-postgres`](https://github.com/code-corhuila/drp-infra-postgres). No database container here. `drp-payment-api` must not own DDL.

Model: `drp-docs` `06-data/models.md` (schema `payment`, user `payment_app`). Unique `idempotency_key` is BR-004. Amount is `amount_cents` (integer minor units).

## Layout (Anexo J)

| Folder | Content |
|--------|---------|
| `01_ddl/` | `payments` (schema-qualified) |
| `02_dml/` | no Corte 2 seed |
| `03_dcl/` | grants for `payment_app` (no DELETE; fail/confirm is a state) |
| `04_tcl/` | reserved |
| `05_rollbacks/` | local undo |
| `deploy/compose.yml` | Flyway job only |

Control table: `payment.flyway_payment_history`.

## Run

```bash
# infra first
docker compose --env-file env/dev.env -f deploy/compose.yml up -d

# this repo
docker compose --env-file .env.example -f deploy/compose.yml run --rm payment-migrate
```

Corte 2 UI (`drp-front`) does **not** need this migrate: it uses synthetic contract data.

## Branching

Child of `develop` named `feat/…`. Never commit on `develop` / `qa` / `main`. Promote with `cherry-pick -x`.
