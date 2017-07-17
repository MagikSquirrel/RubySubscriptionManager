#!/usr/bin/env ruby -w
require "sqlite3"

# Create new tables
rows = db.execute <<-SQL
  CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    email varchar(64)
  );
SQL
