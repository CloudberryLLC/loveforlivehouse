source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.1'
# Use sqlite3 as the database for Active Record
gem 'bootsnap', require: false
gem 'sqlite3', '~> 1.3.0', group: [:development, :test]
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
# bootstrap sass
gem 'bootstrap', '~> 4.3'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5.2.0'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

#ここから下は自分で追加
gem 'jquery-rails'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# cueing backend
gem 'resque', :require => 'resque/server'
# Use ActiveModel has_secure_password
gem 'resque-scheduler'
gem 'bcrypt', '~> 3.1.7'

#-----ここから自分で追加したGem-----
gem "figaro"
gem 'react-rails'
gem 'webpacker', '~> 4.0'
gem 'autoprefixer-rails'
gem 'devise'
gem 'devise-two-factor'
gem "font-awesome-rails"
gem 'bootstrap-toggle-rails'
gem 'toastr-rails'
gem 'i18n'
gem 'devise-i18n'
gem 'carrierwave', '~> 1.0'
gem 'rmagick' #サーバにImageMagickのインストールが必要 https://qiita.com/sho012b/items/362abe993248c686fcf4
gem 'mini_magick' #名刺のQRコード表示
gem 'rqrcode'
gem 'geocoder' #Google Map 廃止予定
gem 'gmaps4rails' #Google Map 廃止予定
gem 'acts-as-taggable-on' #タグ付け機能
gem 'chart-js-rails', '~> 0.1.4' #レビューのレーダーチャート
gem 'rails_admin', '~> 2.0' #admin関連
gem 'cancancan'
gem "aws-sdk-s3", require: false
gem 'stripe', :git => 'https://github.com/stripe/stripe-ruby'
gem 'trix-rails', require: 'trix'
gem 'business_time'
gem 'holiday_jp'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
  gem "rack-dev-mark"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
