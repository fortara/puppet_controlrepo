source 'https://rubygems.org'

group :development do
  gem 'pry'
  gem 'pry-byebug'
end

group :acceptance do
  gem 'beaker-rspec'
end

if ENV['CONTROLREPO_gem'] == 'local'
  gem 'controlrepo', :path => '/Users/dylanratcliffe/git/controlrepo_gem'
else
  gem 'controlrepo', :git => 'https://github.com/dylanratcliffe/controlrepo_gem.git'
end

gem 'r10k'
gem 'puppetlabs_spec_helper'
gem 'rspec-puppet'
gem "rake"
