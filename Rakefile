require 'rake/testtask'
require 'rubocop/rake_task'
require 'bundler/gem_tasks'

RuboCop::RakeTask.new

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/test*.rb']
end

desc 'Run tests'
task default: :test
