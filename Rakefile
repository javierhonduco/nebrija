require 'rake/testtask'
require_relative './lib/version'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/test*.rb']
end

desc 'Run tests'
task :default => :test

desc 'Publish in RubyGems'
task :publish do
  system 'gem build nebrija.gemspec'
  system "gem push nebrija-#{Rae::version}.gem"
end
