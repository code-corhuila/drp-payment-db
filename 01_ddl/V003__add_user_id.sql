-- Owner copy for E-15 USER lists. Not a FK to identity.users (Anexo J).
ALTER TABLE payment.payments
  ADD COLUMN user_id UUID;

CREATE INDEX idx_payments_user
  ON payment.payments (user_id);
