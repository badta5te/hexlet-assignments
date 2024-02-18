# frozen_string_literal: true

# BEGIN
require 'uri'
require 'forwardable'

class Url
  extend Forwardable
  include Comparable

  def_delegators :@url, :scheme, :host, :port, :query

  def initialize(url)
    @url = URI(url)
  end

  def query_params
    @query_params ||= query&.split('&')&.each_with_object({}) do |pair, result|
      key, value = pair.split('=')
      result[key.to_sym] = value
    end || {}
  end

  def query_param(key, default_value = nil)
    @query_params&.dig(key) || default_value
  end

  def <=>(other)
    [scheme, host, port, query_params] <=> [other.scheme, other.host, other.port, other.query_params]
  end
end
# END
