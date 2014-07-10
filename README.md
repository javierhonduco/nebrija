Description
===========

Blablablá.

Searching
=========
Run:
```bash
$ gem install nokogiri typhoeus
```
Then clone the repo and you're ready to go.
```bash
$ ruby app.rb <word>
```

API
===
```ruby
require './rae.rb'
res = HTTPRae.new.search('word')
puts res # prints the results
```

TODO
====
* Check it works properly.
* Search by id.
* Improve the code.
* Handle errors.
* Set a request timeout.
* Get it working without using cURL directly.
* Doc.
* Improve the API.
* Add Gemfile.