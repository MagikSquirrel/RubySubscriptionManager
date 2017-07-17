#!/usr/bin/env ruby -w
require "sqlite3"

# Create new tables
rows = db.execute <<-SQL
  CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    email varchar(64)
  );
SQL

rows = db.execute <<-SQL
  CREATE TABLE processor (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name varchar(32),
    type varchar(16)
  );
SQL