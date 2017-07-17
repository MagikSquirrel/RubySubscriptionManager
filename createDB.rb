#!/usr/bin/env ruby -w
require "sqlite3"

# Open a database
db = SQLite3::Database.new "sqlite3.db"

# Drop old tables
rows = db.execute <<-SQL
  DROP TABLE IF EXISTS user;
SQL

rows = db.execute <<-SQL
  DROP TABLE IF EXISTS processor;
SQL

rows = db.execute <<-SQL
  DROP TABLE IF EXISTS pmt_interval;
SQL

rows = db.execute <<-SQL
  DROP TABLE IF EXISTS subscription;
SQL

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
  CREATE TABLE subscription (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id int,
    processor_id int,
    pmt_interval_id int,
    lastPayment int,
    expiration int,
    json_processor_data BLOB
  ); 
SQL

# Insert starting data
users = ["userA@company1.com", "userB@company2.com","userC@company1.com"]

users.each do |user|
  db.execute("INSERT INTO user VALUES (null, ?);", user)
end

# Find a few rows
sqlSelect = <<-SQL
  SELECT * FROM user;
SQL
db.execute( sqlSelect ) do |row|
  p row
end