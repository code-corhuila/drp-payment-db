-- Schema `payment` already exists in drp-infra-postgres. Do not CREATE EXTENSION.
-- Qualify the schema so Flyway cannot land tables elsewhere.
-- reservation_id is a reference, not a cross-domain FK (Anexo J).
-- Money is integer minor units (amount_cents). UNIQUE idempotency_key is BR-004.

CREATE TABLE payment.payments (
  id                 UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  reservation_id     UUID NOT NULL,
  amount_cents       INTEGER NOT NULL CHECK (amount_cents > 0),
  currency           CHAR(3) NOT NULL DEFAULT 'COP',
  state              VARCHAR(32) NOT NULL
                     CHECK (state IN ('PENDING', 'CONFIRMED', 'FAILED')),
  idempotency_key    VARCHAR(128) NOT NULL,
  provider_reference VARCHAR(128),
  created_at         TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at         TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  UNIQUE (idempotency_key)
);

CREATE INDEX idx_payments_reservation
  ON payment.payments (reservation_id);
