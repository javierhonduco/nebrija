$LOAD_PATH << 'lib' && require('nebrija/version')

Gem::Specification.new do |s|
  s.name = 'nebrija'
  s.version = Nebrija::VERSION
  s.executables << 'nebrija'

  s.authors = ['javierhonduco']
  s.date = Time.now.utc.strftime('%Y-%m-%d')
  s.description = 'A gem to access the RAE dictionary'
  s.email = 'javierhonduco@gmail.com'
  s.files = `git ls-files`.split($/)
  s.test_files = ['test/test_rae.rb']
  s.homepage = 'http://rubygems.org/gems/nebrija'

  s.require_paths = ['lib']
  s.summary = 'This gem makes easy accessing RAE webpage in a programmatic way'

  s.add_dependency('nokogiri', '~> 1.8.1')

  s.add_development_dependency('rake', '~> 12.3.0')
  s.add_development_dependency('webmock', '~> 3.1.1')
  s.add_development_dependency('minitest', '~> 5.10.3')
  s.add_development_dependency('rubocop', '~> 0.51.0')

  s.license = 'MIT'
end
