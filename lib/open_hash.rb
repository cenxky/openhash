# frozen_string_literal: true

require 'ostruct'

# OpenHash lets Hash called and assigned by the key in chainable way.
# Example:
#
#   person = OpenHash.new(name: "John Smith", hometown: { city: "London" })
#   person.name #=> "John Smith"
#   person.hometown.city #=> "London"
#
#   person = OpenHash.new
#   person.name = "Piter Lee"
#   person.hometown.city = "Guangzhou"
#   person.parents.father.name = "Heron Lee"
#   person #=> { name: "Piter Lee", hometown: { city: "Guangzhou" }, parents: { father: { name: "Heron Lee" } } }
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
    def initialize(ohash, *args)
      @ohash = ohash
      @chain_methods = args
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
          last_ohash[method_name] = ::OpenHash.new
          last_ohash = last_ohash[method_name]
        end

        last_ohash[name] = args[0]
      else
        self << name
      end
    end
  end
end
