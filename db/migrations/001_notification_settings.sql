CREATE TABLE notification_settings (
  user_id TEXT PRIMARY KEY,
  email_enabled BOOLEAN NOT NULL DEFAULT TRUE,
  sms_enabled BOOLEAN NOT NULL DEFAULT FALSE
);
