## Nebrija: A rae parser

[![Build Status](https://travis-ci.org/javierhonduco/nebrija.svg?branch=master)](https://travis-ci.org/javierhonduco/nebrija)
[![Gem Version](https://badge.fury.io/rb/nebrija.svg)](https://badge.fury.io/rb/nebrija)
[![Code Climate](https://img.shields.io/codeclimate/github/javierhonduco/nebrija.svg)](https://codeclimate.com/github/javierhonduco/nebrija)


### Installing
```bash
$ gem install nebrija
```

### Usage
```ruby
require 'nebrija'
res = Rae.search('word/id') # e.g. Rae.search('amigo')

puts res # prints the results
```

`Rae#search` returns a hash where the key `status` can be [`error`|`success`].

If the request is successful, the key `type` indicates whether the result type is a single word or multiple  with [`single`|`multiple`].

The response data can be found in the `response` key which holds a hash with all the information.

An example on how to iterate over the info can be seen in the [CLI code](https://github.com/javierhonduco/nebrija/blob/master/lib/nebrija/cli.rb) file:

Typeahead queries supported too! `Rae#typeahed(word)` returns an array of the suggestions.

### CLI
```bash
$ nebrija <word>
```

If you feel it is too cumbersome to type, you can add an alias :)

### Projects using this gem
* [Rae downloader](https://github.com/raul/rae-downloader) by [@raul](https://github.com/raul)
* [Dulcinea: a nebrija frontend](https://github.com/javierhonduco/dulcinea)

### Contributing
Feel free to submit any issue or PR 😃.

In order to test your changes:
```bash
# you can run the tests
$ bundle exec rake [test]
# run the CLI
$ bundle exec nebrija word-to-be-searched
# run the "debug" CLI, which pretty prints the resulting hash
$ bundle exec bin/debug word-to-be-searched
```

Additionally, you can get some debug traces in stderr via the `NEBRIJA_DEBUG` environment variable.

When set, it will output the requested word, the generated URL, and the HTTP status code that it got from the server.
If you wish to see the returned body's output as well, you can set it to `2`.

The tests are [mocked](https://en.wikipedia.org/wiki/Mock_object) so we run our tests using some already downloaded answers from rae.es. However, in some cases, one would like to bypass the mocks and use the real webpages instead. You can achieve that by setting the `NO_MOCK` env var when running your tests.

It was added as part as the continuous integrations testing with Travis. They introduced an amazing feature, 💛💚💙💖[scheduled builds](https://blog.travis-ci.com/2016-12-06-the-crons-are-here). Given that rae.es changes the way its [auth method](https://github.com/javierhonduco/nebrija/blob/086f1cc0341cad538b9c72406fe76bbb6d5d4394/lib/nebrija/rae.rb#L38-L49) works from time to time, the tests without being mocked are run in a daily basis so we know if something is broken.
### TODO
* Make the parser more readable.
* Improve the API.
* Think on multiple responses and how to address them.
