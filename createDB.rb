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

rows = db.execute <<-SQL
  CREATE TABLE pmt_interval (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    type varchar(8),
    cents int
  );
SQL

rows = db.execute <<-SQL
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id int,
    processor_id int,
    pmt_interval_id int,
    lastPayment int,
    expiration int,
    json_processor_data BLOB
  ); 
SQL
