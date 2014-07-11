![](https://api.travis-ci.org/javierhonduco/nebrija.svg )

Description
-----------
Blablablá.

Install
-------
Run:
```bash
$ gem install nebrija
```

Searching
---------
```bash
$ nebrija <word>
```

API
---
```ruby
require 'nebrija'
res = HTTPRae.new.search('word')
puts res # prints the results
```

TODO
----
* Check it works properly.
* ~~Search by id.~~
* Improve the code.
* Handle errors.
* Set a request timeout.
* ~~Get it working without using cURL directly.~~
* Doc.
* Improve the API.
* ~~Add Gemfile.~~
