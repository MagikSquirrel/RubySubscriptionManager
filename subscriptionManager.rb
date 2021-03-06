#!/usr/bin/env ruby -w

#Class that reaches out to the processor's payment network to process payments
class Charger
  @@method
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
  
  def submitPayment(provider, email, account, amount, txType) 
  
    #Pick the specific URL based on the provider type
    case provider.type
      when "credit"
        url = "https://fakecreditcard.com/charge/"
        headers = {'subscriber_id' => account}
        post_data = {'amount' => amount}
      when "online"
        url = "https://www.privateinternetaccess.com/paypal"
        post_data = {
          'subscriber_id' => account,
          'amount' => amount,
          'email' => email, 
          'transaction_type' => txType
        }
    end

    # Build the request and send it to the API
  html_request = Net::HTTP.new(provider.apiUrl, 443)   

  response = html_request.post(url, post_data, headers)
  response_string = response.body.to_s
  puts response_string
  
  end

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

  def sendMail(from, to, sub, msg) 
  
    #Build message
    email = <<EMAIL_END
    From: %s
    To: %s
    Subject: %s

    %s
EMAIL_END
  
    # Insert message params
    email = email % [from, to, sub, msg]

    # Send it from our mail server
    
    # Todo add authentication/security/TLS
    Net::SMTP.start('localhost') do |smtp|
      smtp.send_message email, from, to
    end
  end
end


class User

end

