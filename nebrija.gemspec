$: << 'lib' and require 'nebrija/version'

Gem::Specification.new do |s|
  s.name = 'nebrija'
  s.version = Nebrija::VERSION
  s.executables << 'nebrija'

  s.authors = ['@javierhonduco']
  s.date = Time.now.utc.strftime('%Y-%m-%d')
  s.description = 'A gem to access the rae dictionary'
  s.email = 'javierhonduco@gmail.com'
  s.files = `git ls-files`.split($/)
  s.test_files = ['test/test_rae.rb']
  s.homepage = 'http://rubygems.org/gems/nebrija'

  s.require_paths = ['lib']
  s.summary = 'This gem provides access to the rae webpage'

  s.add_dependency('nokogiri')
  s.add_dependency('typhoeus', '~> 0')

  s.add_development_dependency('rake', '~> 0')
  s.add_development_dependency('minitest', '~> 5')
  s.add_development_dependency('webmock', '~> 1.18.0', '>= 1.18.0')

  s.license = 'MIT'
end
