namespace :run do
  desc "Run Ruby benchmark"
  task :ruby do
    sh "ruby ruby_io_speed.rb"
  end

  desc "Run Node benchmark"
  task :node do
    sh "node node_io_speed.js"
  end

  desc "Run all benchmarks"
  task :all => [:ruby, :node]
end

namespace :install do
  desc "Install node dependencies"
  task :node do
    sh "npm install"
  end

  desc "Install ruby dependencies"
  task :ruby do
    sh "bundle install"
  end

  desc "Install all dependencies"
  task :all => [:ruby, :node]
end

desc "Install all dependencies and run all benchmarks"
task :default => ["install:all", "run:all"]
