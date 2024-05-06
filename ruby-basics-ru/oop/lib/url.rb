# frozen_string_literal: true

# BEGIN
require 'forwardable'
require 'uri'

class Url
  include Comparable

  extend Forwardable
  def_delegators :@uri, :scheme, :host, :port

  def initialize(uri)
    @uri = URI(uri)
  end

  def <=>(other)
    source = [@uri.scheme, @uri.host, @uri.port, self.search]
    target = [other.scheme, other.host, other.port, other.search]
    source <=> target
  end

  def search
    self.query_params.map { |key, value| "#{key}=#{value}" }.join('&')
  end

  def query_param(key, default=nil)
    params = query_params()

    if (params.key?(key))
      return params[key]
    end

    default
  end

  def query_params()
    if @uri.query.nil?
      return {}
    end

    @uri.query.split('&')
      .map { |text| text.split('=') }
      .sort_by { |key| key }
      .to_h
      .transform_keys(&:to_sym)
  end
end
# END
