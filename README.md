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
res = HTTPRae.new.search('word/id') 
puts res # prints the results
```

`HTTPRae` returns a hash where the key `status` can be `error`|`success`.

If the request is succesful, the key `type` indicates wheter the result type is a single word or multiple  with `single`|`multiple`.

The response data can be found in the `response` key which is an array.

The response data is formatted as shown below:
* Single responses
```ruby
[{:word=>"banca", :id=>"N4sDS8D9sDXX2ydchkDs"}, {:word=>"bancar", :id=>"MHpGWYJ6YDXX2bw9Ghwm"}, {:word=>"bance", :id=>"dkcRaDoJTDXX2mbtZ21J"}, {:word=>"banco", :id=>"E0yO6yORQDXX2M4zQtJ3"}]
```
* Multiple responses
```ruby
[{:word=>"A-1.", :etymology=>"(Del gr. ἀ-, priv.).", :meanings=>[{:word=>"Carece de significación precisa. Amatar. Asustar. Avenar.", :meta=>"pref."}]}, {:word=>"A1.", :etymology=> nil, :meanings=>[{:word=>"Primera letra del abecedario español y del orden latino internacional, que representa un fonema vocálico abierto y central.", :meta=>"f."}, {:word=>"Signo de la proposición universal afirmativa.", :meta=>"Fil."}]}, {:word=>"~ por ~ y b por b.", :etymology=> nil, :meanings=>[{:word=>"punto por punto.", :meta=>"adv."}]}, {:word=>"A-2.", :etymology=> nil, :meanings=>[{:word=>"Denota privación o negación. Acromático. Ateísmo. Ante vocal toma la forma an-. Anestesia. Anorexia.", :meta=>"pref."}]}]
```
CLI searching
---------
```bash
$ nebrija <word>
```

Friend projects/ project using this gem
---------------------------------------
* [Rae downloader](https://github.com/raul/rae-downloader) by @raul

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
