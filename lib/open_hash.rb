# frozen_string_literal: true

require 'ostruct'

# OpenHash lets Hash called and assigned by the key in chainable way.
# Example:
#
#   person = OpenHash.new(name: "John", hometown: { city: "London" })
#   person.name #=> "John"
#   person.hometown.city #=> "London"
#
#   person = OpenHash.new
#   person.name = "Lion"
#   person.hometown.city = "Paris"
#   person.parents.father.name = "Heron"
#   person #=> { name: "Lion", hometown: { city: "Paris" }, parents: { father: { name: "Heron" } } }
#
class OpenHash < OpenStruct
  def initialize(hash = {})
    hash = hash.each_with_object({}) do |(k, v), r|
      r[k] = v.is_a?(Hash) ? OpenHash.new(v) : v
    end

    super
  end

  alias inspect to_h

  def method_missing(name, *args) # :nodoc:
    super || BlackHole.new(self, name)
  end

  # BlackHole Class
  class BlackHole < BasicObject
    DELEGATE_REGEX = /(.+\?)|(to_.+)|(={2,3})\z/.freeze
    @nil_methods = ::NilClass.instance_methods(false).grep(DELEGATE_REGEX)

    def initialize(ohash, *args)
      @ohash = ohash
      @chain_methods = args
    end

    @nil_methods.each do |method_name|
      define_method method_name do |*args|
        nil.send(method_name, *args)
      end
    end

    def inspect
      "nil"
    end

    # Append a method name to chain methods
    def <<(method_name)
      @chain_methods << method_name
      self
    end

    def method_missing(name, *args) # :nodoc:
      case name
      when /([^=]+)=\z/
        last_ohash = @ohash

        @chain_methods.each do |method_name|
          last_ohash = if last_ohash.respond_to?(method_name)
            last_ohash[method_name]
          else
            last_ohash[method_name] = ::OpenHash.new
          end
        end

        last_ohash[$1] = args[0]
      else
        self << name
      end
    end
  end
end
