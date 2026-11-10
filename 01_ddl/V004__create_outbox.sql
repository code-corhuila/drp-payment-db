-- Transactional outbox (Anexo J / TD-003). Same schema payment. No AMQP yet.
-- Relay reads unpublished rows; HTTP hop until BROKER_URL exists.

CREATE TABLE payment.outbox (
  event_id         UUID PRIMARY KEY,
  event_type       VARCHAR(64) NOT NULL,
  aggregate_id     UUID NOT NULL,
  aggregate_type   VARCHAR(32) NOT NULL,
  topic            VARCHAR(64) NOT NULL,
  occurred_at      TIMESTAMPTZ NOT NULL,
  version          INTEGER NOT NULL DEFAULT 1,
  payload          JSONB NOT NULL,
  correlation_id   VARCHAR(128),
  published_at     TIMESTAMPTZ
);

CREATE INDEX idx_outbox_unpublished
  ON payment.outbox (occurred_at)
  WHERE published_at IS NULL;
