source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.2'

# Rails framework
gem 'rails', '~> 6.1.6.1'

# Application server
gem 'puma', '>= 5.6.4'

# Stylesheets
gem 'sass-rails', '~> 6.0'

# JavaScript compressor
gem 'uglifier', '~> 4.2.0'

# jQuery library
gem 'jquery-rails', '~> 4.4'

# Navigation enhancement
gem 'turbolinks', '~> 5.2.1'

# JSON APIs
gem 'jbuilder', '~> 2.11'

# Password hashing
gem 'bcrypt', '~> 3.1'

# AWS S3 integration
gem 'aws-sdk-s3', '~> 1.114'

# Web server for local development
gem 'webrick', '~> 1.7'

# Mail library
gem 'mail', '>= 2.8.0.rc1'

# Caching for faster boot times
gem 'bootsnap', '>= 1.13', require: false

# Network IO library
gem 'nio4r', '2.7.2'

# Remove Devise gem for user authentication
# gem 'devise', '~> 4.9'  # Devise for user authentication

group :development, :test do
  # Debugging tools
  gem 'byebug', '~> 11.1.3', platforms: %i[mri mingw x64_mingw]

  # Improved output formatting
  gem 'awesome_print', '~> 1.9'

  # Environment variable management
  gem 'dotenv-rails', '~> 2.8'

  # Factories for tests
  gem 'factory_bot_rails', '~> 6.2'

  # Interactive console enhancements
  gem 'pry-rails', '>= 0.3.9'

  # Testing framework
  gem 'rspec-rails', '~> 5.1'

  # Linting and style enforcement
  gem 'rubocop', '~> 1.36'
  gem 'rubocop-rspec', '2.12'
end

group :development do
  # File system monitoring
  gem 'listen', '~> 3.7.1'

  # Web-based console for errors
  gem 'web-console', '>= 4.2'

  # Application preloader
  gem 'spring', '< 3.0'

  # Database for development
  gem 'sqlite3', '~> 1.5.0'
end

group :production do
  # Database for production
  gem 'pg', '~> 1.4', '>= 1.4.3', require: false
end

# String scanner for Ruby
gem 'strscan', '3.0.4'

