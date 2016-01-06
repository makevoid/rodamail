# Usage:
#
# Mailer.deliver(
#   from_address: "test@example.com"
#   subject:      "hi!"
#   body:         "O hai!"
# )
#

class Mailer

  def self.deliver(from_address:, subject:, body:)
    message = Mail.new do
            to ADDRESS_RECIPIENT
          from SENDER_ADDRESS
      reply_to from_address
       subject subject
          body body
    end

    if APP_ENV == "development"
      debug_message message, body: body
    else
      puts "Sent mail: '#{subject}' - from: '#{from_address}'"
      message.deliver
    end
  end

  def self.debug_message(message, body:)
    puts "Mail:"
    p message
    puts "Body"
    p body
    puts
  end

end
