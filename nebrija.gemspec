Gem::Specification.new do |s|
  s.name = 'nebrija'
  s.version = '1.0.5'
  s.executables << 'nebrija'

  s.authors = ['@javierhonduco']
  s.date = Time.now.utc.strftime('%Y-%m-%d')
  s.description = 'A gem to access the rae dictionary'
  s.email = 'javierhonduco@gmail.com'
  s.files = ['Rakefile', 'lib/nebrija.rb', 'lib/nebrija/parser.rb', 'bin/nebrija']
  s.test_files = ['test/test_rae.rb']
  s.homepage = 'http://rubygems.org/gems/nebrija'
  s.require_paths = ['lib']
  s.rubygems_version = '1.8.23'
  s.summary = 'This gem provides access to the rae webpage'

  s.add_dependency('nokogiri')
  s.add_dependency('typhoeus', '~> 0')

  s.add_development_dependency('rake', '~> 0')
  s.add_development_dependency('minitest', '~> 5')
  s.add_development_dependency('webmock', '~> 1.18.0', '>= 1.18.0')

  s.license = 'MIT'
end
