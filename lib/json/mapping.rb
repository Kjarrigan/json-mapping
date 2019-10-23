# frozen_string_literal: true

require 'json'
require 'json/mapping/version'

module JSON
  class Mapping
    class Error < StandardError; end
  end

  def self.mapping(klass, fields)
    fields.each do |name, typ|
      klass.attr_reader name
      klass.define_method "#{name}=" do |value|
        value = typ.new(value) if typ.respond_to?(:from_json)
        unless value.is_a?(typ)
          raise JSON::Mapping::Error, "Wrong field type #{self.class} for '#{name}' - should be '#{typ}'"
        end

        instance_variable_set "@#{name}", value
      end
    end

    klass.define_method :initialize do |params = {}|
      params.each do |name, value|
        unless fields.key?(name.to_sym)
          raise JSON::Mapping::Error, "Missing field definition for '#{name}'"
        end

        send("#{name}=", value)
      end
    end

    klass.define_singleton_method :from_json do |string|
      klass.new(JSON.parse(string))
    end
  end
end
