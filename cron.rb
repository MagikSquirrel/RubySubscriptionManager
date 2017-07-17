# Load all the subscriptions in the database
db.execute( "select * from pmt_user" ) do |row|
  p row
end

# Get a list of all upcoming payments where monthly >= 1, annual >= 12 (in months), or == 0 (new subscription)

# Charge all payment types based on the interval's rate (1000 cents = $10.00)

# Send an appropiate email to the user

# Update successful payments to the DB