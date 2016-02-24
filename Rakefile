require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/test*.rb']
end

desc 'Run tests'
task :default => :test

desc 'Publish'
task :publish do
  $: << 'lib' and require 'nebrija/version'
  version = Nebrija::VERSION

  `gem build nebrija.gemspec`
  `gem install nebrija-#{version}.gem`
  `gem push nebrija-#{version}.gem`
  `rm *.gem`
end
