# RodaMail

A simle mail sending API (one route) to send email message by using the ruby mail gem (already configured for sending via gmail). This API is meant to be used to back a JS contact form, but feel free to modify to send any kind of messages (alert, logs, etc...).

### Install dependencies

    bundle

### Configure

Edit ./config/env.rb

### Run

    bundle exec rackup

### One route

    POST /mail

    from_name:    "Mario Foo"
    from_address: "mario@example.com",
    subject:      "foo",
    body:         "bar"

easy as that,

enjoy!


@makevoid
