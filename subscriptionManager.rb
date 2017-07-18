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
  @@sender
  @@recipient
  @@subject
  
  #Mailer specific enums
  enum SUBJECTS: {
    SUCCESS: "Your payment was successful",
    FAILURE: "Your payment was UNsuccessful."
  }
  
  enum MESSAGES: {
    SUCCESS: "Congratulations you\'ve successfully paid your [post]interval[/post] bill for service totaling [post]amount[/post] with payment method [post]method[/post] indentified by [post]account[/post].",
    FAILURE: "Unfortunately the payment method [post]method[/post] identified by [post]account[/post] was unsuccessful for [post]amount[/post] for your [post]interval[/post] payment. Please correct payment or contact our support at [post]supportEmail[/post]"
  }

end

class User

end

