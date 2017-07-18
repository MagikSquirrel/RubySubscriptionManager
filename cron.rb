#!/usr/bin/env ruby -w
require "sqlite3"

# Open a database
db = SQLite3::Database.new "sqlite3.db"

# Load all the subscriptions in the database
sqlSelect = <<-SQL
  SELECT u.email, i.type, p.name, p.type,
    strftime("%m-%d-%Y", lastPayment, 'unixepoch') AS lastPayment,
    strftime("%m-%d-%Y", expiration, 'unixepoch') AS expiration
  FROM subscription AS s
    INNER JOIN user AS u ON u.id = s.user_id
    INNER JOIN processor AS p ON p.id = s.processor_id
    INNER JOIN pmt_interval AS i ON i.id = s.pmt_interval_id
  WHERE
    ( julianday(lastPayment) - julianday(date('now')) >= 30 AND i.type = 'monthly') OR
    ( julianday(lastPayment) - julianday(date('now')) >= 365 AND i.type = 'annual') OR
    lastPayment IS NULL
SQL
db.execute( sqlSelect ) do |row|
  p row
end

# Get a list of all upcoming payments where monthly >= 1, annual >= 12 (in months), or == 0 (new subscription)

# Charge all payment types based on the interval's rate (1000 cents = $10.00)

# Send an appropiate email to the user

# Update successful payments to the DB