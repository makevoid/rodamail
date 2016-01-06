require 'bundler'
Bundler.require :default
require_relative "../lib/mailer"

APP_ENV = ENV["RACK_ENV"] || "development"

# ------------------------------------------------------
# Configurations:
#
# the receiving address(es) of all the email messages
ADDRESS_RECIPIENT = "francesco@appliedblockchain.com"
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
