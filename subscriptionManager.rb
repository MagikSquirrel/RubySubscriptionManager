#!/usr/bin/env ruby -w

#Class that reaches out to the processor's payment network to process payments
class  @@method
  @@cents #Use cents to not have to deal with floats
  
  def method
    puts method
  end
  
  def cents
    puts cents
  end
  
  #Various Transaction Types
  enum TX_TYPES: [
    SIGNUP,
    RENEWAL,
    FAILED_CHARGE
  ]
end

#Class that associates with a payment provider
class Provider
  @@name
  @@type
  @@apiUrl
end

#Class that handles the mailing operations
class Mailer 

end

class User

end

