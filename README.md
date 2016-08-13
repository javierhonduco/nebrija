Nebrija: A rae parser
=====================

[![Build Status](https://travis-ci.org/javierhonduco/nebrija.svg?branch=master)](https://travis-ci.org/javierhonduco/nebrija)
[![Code Climate](https://img.shields.io/codeclimate/github/javierhonduco/nebrija.svg)](https://codeclimate.com/github/javierhonduco/nebrija)


Install
-------

```bash
$ gem install nebrija
```

API
---
```ruby
require 'nebrija'
res = Rae.new.search('word/id')
puts res # prints the results
```

`HTTPRae` returns a hash where the key `status` can be `error`|`success`.

If the request is succesful, the key `type` indicates whether the result type is a single word or multiple  with `single`|`multiple`.

The response data can be found in the `response` key which holds an array.

The response data is formatted as shown in the [nebrija/cli](https://github.com/javierhonduco/nebrija/blob/master/lib/nebrija/cli.rb) file:

CLI searching
---------
```bash
$ nebrija <word>
```

Maybe you are lazy and want to add an alias to `rae` or `es` like I do :)

Friend projects/ project using this gem
---------------------------------------
* [Rae downloader](https://github.com/raul/rae-downloader) by [@raul](https://github.com/raul)
* [Dulcinea: a nebrija frontend](https://github.com/javierhonduco/dulcinea)

TODO
----
* Improve the API.
* Update clients to use new API.
* Fix multiple responses.
* Better doc.
* Mockless testing.
* Make the parser more readable.
