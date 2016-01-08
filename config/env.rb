require 'bundler'
Bundler.require :default
require_relative "../lib/mailer"

APP_ENV = ENV["RACK_ENV"] || "development"

PATH = File.expand_path "../../", __FILE__

recipient_file = File.expand_path "#{PATH}/config/recipient.txt"
recipient_address = if File.exists? recipient_file
  File.read(recipient_file).strip
end

# ------------------------------------------------------
# Configurations:
#
# the receiving address(es) of all the email messages
ADDRESS_RECIPIENT = recipient_address || "francesco@appliedblockchain.com"
#
# the email / gmail account that will send the message (you have to have the password to authenticate)
SENDER_ADDRESS    = 'm4kevoid@gmail.com'
password_file     = "~/.rodamail_password"
#
# ------------------------------------------------------

mail_pass = File.read(File.expand_path password_file).strip

smtp_options = {
  address:              "smtp.gmail.com",
  port:                 587,
  user_name:            SENDER_ADDRESS,
  password:             mail_pass,
  enable_starttls_auto: true
}

Mail.defaults do
  delivery_method :smtp, smtp_options
end
