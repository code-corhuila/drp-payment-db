DROP INDEX IF EXISTS payment.idx_payments_user;
ALTER TABLE payment.payments DROP COLUMN IF EXISTS user_id;
