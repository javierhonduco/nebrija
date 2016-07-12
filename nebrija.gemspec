$LOAD_PATH << 'lib' && require('nebrija/version')

Gem::Specification.new do |s|
  s.name = 'nebrija'
  s.version = Nebrija::VERSION
  s.executables << 'nebrija'

  s.authors = ['javierhonduco']
  s.date = Time.now.utc.strftime('%Y-%m-%d')
  s.description = 'A gem to access the RAE dictionary'
  s.email = 'javierhonduco@gmail.com'
  s.files = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  s.test_files = ['test/test_rae.rb']
  s.homepage = 'http://rubygems.org/gems/nebrija'

  s.require_paths = ['lib']
  s.summary = 'This gem makes easy accessing RAE webpage in a programmatic way'

  s.add_dependency('nokogiri', '~> 1.6.8')
  s.add_dependency('faraday', '~> 0.8.11')

  s.add_development_dependency('rake', '~> 11.2.2')
  s.add_development_dependency('webmock', '~> 2.1.0')
  s.add_development_dependency('minitest', '~> 5.9.0')
  s.add_development_dependency('rubocop', '~> 0.41.1')

  s.license = 'MIT'
end
