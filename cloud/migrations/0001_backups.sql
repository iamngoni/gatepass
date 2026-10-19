-- One sealed backup per account. `account` is the hashed Firebase uid.
CREATE TABLE backups (
  account TEXT PRIMARY KEY NOT NULL,
  version INTEGER NOT NULL CHECK (version > 0),
  updated_at TEXT NOT NULL,
  blob TEXT NOT NULL
) STRICT;
