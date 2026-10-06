-- payment_app already has USAGE, CREATE on schema payment (infra init).
-- Tables created by Flyway are owned by payment_app.

GRANT SELECT, INSERT, UPDATE ON ALL TABLES IN SCHEMA payment TO payment_app;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA payment TO payment_app;
-- No DELETE: lifecycle is PENDING | CONFIRMED | FAILED.
