# frozen_string_literal: true

require 'digest'

class Signature
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)

    response_body = body.join
    signature = Digest::SHA256.hexdigest(response_body)

    new_body = "#{response_body}\n#{signature}"

    [status, headers, [new_body]]
  end
end
