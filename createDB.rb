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
processors = [["Visa", "Credit"],["MasterCard", "Credit"],["Discover", "Credit"],["AmericanExpress", "Credit"],["Paypal", "Online"]]
intervals = [["annual", 10000], ["monthly", 1000]]
subscriptions = [[1, 1, 1, 1500329574, 1600329574], [2,2,2,1490329574,1510329574],[3,5,1,1490329574,1510329574]]

users.each do |user|
  db.execute("INSERT INTO user VALUES (null, ?);", user)
end

processors.each do |processor|
  db.execute("INSERT INTO processor VALUES (null, ?,?);", processor)
end

intervals.each do |interval|
  db.execute("INSERT INTO pmt_interval VALUES (null, ?,?);", interval)
end

subscriptions.each do |subs|
  db.execute("INSERT INTO subscription VALUES (null,?,?,?,?,?,null);", subs)
end

# Find a few rows
sqlSelect = <<-SQL
  SELECT u.email, i.type, p.name, p.type,
    strftime("%m-%d-%Y", lastPayment, 'unixepoch') AS lastPayment,
    strftime("%m-%d-%Y", expiration, 'unixepoch') AS expiration
  FROM subscription AS s
    INNER JOIN user AS u ON u.id = s.user_id
    INNER JOIN processor AS p ON p.id = s.processor_id
    INNER JOIN pmt_interval AS i ON i.id = s.pmt_interval_id
SQL
db.execute( sqlSelect ) do |row|
  p row
end
