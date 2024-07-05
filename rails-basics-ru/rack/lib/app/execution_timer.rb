# frozen_string_literal: true

class ExecutionTimer
  def initialize(app)
    @app = app
  end

  def call(env)
    start_time = Process.clock_gettime(Process::CLOCK_MONOTONIC, :microsecond)
    status, headers, body = @app.call(env)
    end_time = Process.clock_gettime(Process::CLOCK_MONOTONIC, :microsecond)

    execution_time = end_time - start_time

    new_body = body.map do |chunk|
      chunk.sub(/\n[a-f0-9]{64}$/, '') + "\nExecution time: #{execution_time.to_i} microseconds\n" + Digest::SHA256.hexdigest(chunk)
    end

    [status, headers, new_body]
  end
end
