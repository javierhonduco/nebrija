Gem::Specification.new do |s|
  s.name = 'nebrija'
  s.version = '0.0.0'
  s.executables << 'nebrija'

  s.authors = ['@javierhonduco']
  s.date = Time.now.utc.strftime('%Y-%m-%d')
  s.description = %q{A gem to access the rae dictionary}
  s.email = %q{a@a.a}
  s.files = ['Rakefile', 'lib/nebrija.rb', 'lib/nebrija/parser.rb', 'bin/nebrija']
  s.test_files = ['test/test_basic.rb']
  s.homepage = %q{http://rubygems.org/gems/nebrija}
  s.require_paths = ['lib']
  s.rubygems_version = %q{1.8.23}
  s.summary = %q{dictionary gem and stuff}

  s.add_dependency(%q<nokogiri>)
  s.add_dependency(%q<typhoeus>)

  s.add_development_dependency('rake')
  s.license = 'MIT'
end

