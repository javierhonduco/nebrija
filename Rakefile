require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/test*.rb']
end

desc 'Run tests'
task :default => :test

desc 'Publish gem'
task :publish do
  puts 'Building gem...'
  puts `gem build nebrija.gemspec` 
  puts
  puts 'Uploading gem...'
  puts `gem push nebrija-0.0.0.gem`
end
