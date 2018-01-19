source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "breadcrumbs_on_rails"
gem "bootstrap-modal-rails"
gem "carrierwave", "1.1.0"
gem "mini_magick", "4.7.0"
gem "fog-aws", "2.0.0"
gem "nokogiri", "1.8.1"
gem "will_paginate", "3.1.6"
gem "bootstrap-will_paginate", "1.0.0"
gem "faker", "1.7.3"
gem "jquery-rails"
gem "config"
gem "rails", "~> 5.1.4"
gem "bootstrap-sass", "3.3.7"
gem "bcrypt","3.1.11"
gem "mysql2", ">= 0.3.18", "< 0.5"
gem "puma", "~> 3.7"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"
gem "i18n-js"
gem "font-awesome-rails"
gem "chartkick"

group :development, :test do
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "capybara", "~> 2.13"
  gem "selenium-webdriver"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
