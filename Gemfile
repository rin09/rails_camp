source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '5.0.6'
gem 'puma',         '3.9.1'
gem 'turbolinks', '~> 5'
gem 'will_paginate',           '3.1.5'
gem 'bootstrap-will_paginate', '1.0.0'
gem 'redis'
gem "faker"

# UI/UX
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'bootstrap-sass' 
gem 'jquery-rails'
gem 'jbuilder', '~> 2.5'
gem 'wareki' 
gem 'font-awesome-rails' 
gem 'rails-i18n' 

# ユーザー機能
gem 'devise' 
gem 'devise-i18n' 
gem 'bcrypt',         '3.1.11' 

# 役割定義
gem 'cancancan' 

# フォーム
gem 'bootstrap_form'

#画像
gem 'carrierwave',             '1.1.0'
gem 'mini_magick',             '4.7.0'
gem 'fog',                     '1.40.0'


group :development, :test do
  gem 'sqlite3', '1.3.13'
  gem 'byebug'
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'rails-controller-testing', '1.0.2'
  gem 'minitest-reporters',       '1.1.14'
  gem 'guard',                    '2.13.0'
  gem 'guard-minitest',           '2.4.4'
end

group :production do
  gem 'pg', '0.20.0'
end

