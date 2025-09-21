source "https://rubygems.org"

ruby "3.4.4"
gem "rails", "~> 7.1.5", ">= 7.1.5.2"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "bcrypt", "~> 3.1.7"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false
gem "rack-cors"
gem 'jwt'
gem 'rspec-rails', group: [:development, :test]

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

