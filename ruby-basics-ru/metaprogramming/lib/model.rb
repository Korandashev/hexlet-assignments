# frozen_string_literal: true

# BEGIN
require 'date'

module Model
  attr_accessor :attributes

  def initialize(attributes = {})
    @attributes = {}

    self.class.options.each do |key, options|
      value = attributes.key?(key) ? attributes[key] : options.fetch(:default, nil)
      options = self.class.options[key]
      @attributes[key] = self.class.convert_attribute(value, options[:type])
    end
  end

  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    attr_reader :options

    def convert_attribute(value, type)   
      return nil if value.nil?
      
      case type
      when :integer
        value.to_i
      when :string
        value.to_s
      when :datetime
        DateTime.parse value
      when :boolean
        value.to_s == 'true'
      end
    end

    def attribute(name, options={})
      @options ||= {}
      @options[name] = options

      define_method "#{name}" do
        @attributes[name]
      end

      define_method "#{name}=" do |value|
        @attributes[name] = self.class.convert_attribute(value, options[:type])
      end
    end
  end
end
# END
