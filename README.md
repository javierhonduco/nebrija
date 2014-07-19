Nebrija: A rae parser
=====================


[![Build Status](https://travis-ci.org/javierhonduco/nebrija.svg?branch=master)](https://travis-ci.org/javierhonduco/nebrija)

[[!Code Climate](http://img.shields.io/codeclimate/github/javierhonduco/nebrija.svg)](https://codeclimate.com/github/javierhonduco/nebrija)


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
* Doc. (return, hacks...)
* Improve the code.
* Add bulk search.
* Set a request timeout.
* ~~Search by id.~~
* ~~Handle errors.~~
* ~~Get it working without using cURL directly.~~
* ~~Improve the API.~~
* ~~Add Gemfile.~~
