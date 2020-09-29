# frozen_string_literal: true

require 'ostruct'

# OpenHash lets Hash called and assigned by the key in chainable way.
# Example:
#
#   person = OpenHash.new(name: "John", hometown: { city: "London" }, pets: [{ name: "Mia", animal: "Cat" }])
#   person.name #=> "John"
#   person.hometown.city #=> "London"
#   person.pets[0].name #=> "Mia"
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
      r[k] = case v
      when Hash, OpenStruct
        OpenHash.new(v)
      when Array
        v.map { |x| OpenHash.new(x) }
      else
        v
      end
    end

    super
  end

  alias inspect to_h

  def method_missing(name, *args) # :nodoc:
    super || BlackHole.new(self, name)
  end

  # BlackHole Class
  class BlackHole < BasicObject
    NIL_METHODS = ::NilClass.instance_methods(false) | %i[== != ! equal? is_a? kind_of? instance_of?]

    def initialize(ohash, *args)
      @ohash = ohash
      @chain_methods = args
    end

    NIL_METHODS.each do |method_name|
      define_method method_name do |*args|
        nil.send(method_name, *args)
      end
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
      when /\A[^a-z_A-Z]+/
        nil.send(name, *args)
      else
        self << name
      end
    end
  end
end
