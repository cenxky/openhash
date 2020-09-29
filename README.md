## OpenHash ##

 OpenHash lets Hash called and assigned by the key in chainable way.

### Installation ###
    # Manually from RubyGems.org
    $ gem install openhash

    # Or Gemfile if you are using Bundler
    $ gem openhash

### Usage ###
```ruby
person = OpenHash.new(name: "John", hometown: { city: "London" }, pets: [{ name: "Mia", animal: "Cat" }])
person.name #=> "John"
person.hometown.city #=> "London"
person.pets[0].name #=> "Mia"

person = OpenHash.new
person.name = "Lion"
person.hometown.city = "Paris"
person.parents.father.name = "Heron"
person #=> { name: "Lion", hometown: { city: "Paris" }, parents: { father: { name: "Heron" } } }
```

### Known Issue ###

Since Ruby doesn't support to override logic oprators,
so please pay attention to use oprators below when you are using `OpenHash`:

- `&&`, `and`
- `||`, `or`
- `&.`

The most recommend way once you have to do some logic checking:

```ruby
person = OpenHash.new

# Wrong
city = person.city || "London"

# Right
city = person.city.nil? ? "London" : person.city

# Wrong
state = person.is_succeed && "Success"

# Right
state = "Success" if !person.is_succeed.nil?

# Wrong
person.city&.upcase

# Right
!person.city.nil? && person.city.upcase
```

### License ###
Released under the [MIT](http://opensource.org/licenses/MIT) license. See LICENSE file for details.
