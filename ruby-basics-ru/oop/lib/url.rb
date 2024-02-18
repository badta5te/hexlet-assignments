# frozen_string_literal: true

# BEGIN
require 'uri'
require 'forwardable'

class Url
  extend Forwardable
  include Comparable

  def initialize(url)
    @url = URI(url)
  end

  def query_params
    @query_params ||= query&.split('&')&.each_with_object({}) do |pair, result|
      key, value = pair.split('=')
      result[key.to_sym] = value
    end || {}
  end

  def query_param(key, default_value = '')
    if @query_params&.dig(key)
      @query_params&.dig(key)
    elsif default_value != ''
      default_value
    end
  end

  def ==(other)
    port == other.port &&
      host == other.host &&
      scheme == other.scheme &&
      query_params.sort == other.query_params.sort
  end

  def_delegators :@url, :scheme, :host, :port
  def_delegator :@url, :query
end
# END
