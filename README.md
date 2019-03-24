## OpenHash ##

 OpenHash lets Hash called and assigned by the key in chainable way.

### Installation ###
    # Manually from RubyGems.org
    $ gem install openhash

    # Or Gemfile if you are using Bundler
    $ gem openhash

### Usage ###
```ruby
#   person = OpenHash.new(name: "John Smith", hometown: { city: "London" })
#   person.name #=> "John Smith"
#   person.hometown.country #=> "UK"
#
#   person = OpenHash.new
#   person.name = "Piter Lee"
#   person.hometown.city = "Guangzhou"
#   person.parents.father.name = "Heron Lee"
#   person #=> { name: "Piter Lee", hometown: { city: "Guangzhou" }, parents: { father: { name: "Heron Lee" } } }
```
### License ###
Released under the [MIT](http://opensource.org/licenses/MIT) license. See LICENSE file for details.
