require_relative "config/env"

class RodaMail < Roda

  def body_layout(from:, body:)
    <<-BODY.gsub(/^\s{4}/, '')
      <h4>New message received from:</h4>
      <h3>#{from}</h1>
      <br>
      <h4>Message:</h4>
      <p>#{body}</p>
    BODY
  end

  def default_response
    <<-BODY.gsub(/^\s{4}/, '')
    <h1>RodaMail</h1>
    <p>There's nothing to see here, please see the <a href='https://github.com/makevoid/rodamail/blob/master/Readme.md'>Readme of this project</a></p>
    BODY
  end

  def default_response_message
    "404 - There's nothing to see here, please see the Readme of this project at: https://github.com/makevoid/rodamail/blob/master/Readme.md"
  end

  plugin :indifferent_params
  plugin :json
  plugin :not_found
  plugin :error_handler

  route do |r|
    # GET / request
    r.root do
      default_response
    end

    r.on "mail" do
      r.is do
        # POST /mail
        r.post do
          response['Access-Control-Allow-Origin']  = '*'
          response['Access-Control-Allow-Headers'] = 'GET, POST, PUT, DELETE, PATCH, HEAD, OPTIONS'
          response['Access-Control-Allow-Headers'] = 'Content-Type'

          from_name    = params[:from_name]    || "blank_name"
          from_address = params[:from_address] || "blank_address"
          body         = params[:body]         || "the_body_was_left_blank"

          from = "#{from_name} <#{from_address}>"
          subject = "New message received from: #{from}"

          body = body_layout(
            from: from,
            body: body,
          )

          Mailer.deliver(
            from_address: from_address,
            subject:      subject,
            body:         body,
          )

          { success: true }
        end
      end
    end
  end

  error do |e|
    err = {
      message: e.message,
    }
    err.merge!(backtrace:  e.backtrace) unless APP_ENV == "production"
    err
  end

  not_found do
    {
      error:  "not_found",
      message: default_response_message,
    }
  end
end
