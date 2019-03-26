## OpenHash ##

 OpenHash lets Hash called and assigned by the key in chainable way.

### Installation ###
    # Manually from RubyGems.org
    $ gem install openhash

    # Or Gemfile if you are using Bundler
    $ gem openhash

### Usage ###
```ruby
person = OpenHash.new(name: "John", hometown: { city: "London" })
person.name #=> "John"
person.hometown.city #=> "London"

person = OpenHash.new
person.name = "Lion"
person.hometown.city = "Paris"
person.parents.father.name = "Heron"
person #=> { name: "Lion", hometown: { city: "Paris" }, parents: { father: { name: "Heron" } } }
```
### License ###
Released under the [MIT](http://opensource.org/licenses/MIT) license. See LICENSE file for details.
