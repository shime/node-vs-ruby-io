namespace :run do
  desc "Run Ruby Minimagick benchmark"
  task "ruby:mini" do
    sh "ruby ruby_io_speed_mm.rb"
  end

  desc "Run Ruby benchmark"
  task :ruby do
    sh "ruby ruby_io_speed.rb"
  end

  desc "Run Node benchmark"
  task :node do
    sh "node node_io_speed.js"
  end

  desc "Run Node benchmark with streams"
  task "node:streams" do
    sh "node node_io_speed_streams.js"
  end

  desc "Run all benchmarks"
  task :all => ["ruby:mini", :ruby, :node, "node:streams"]
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
