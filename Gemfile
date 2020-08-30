source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.6.5"

gem "actionpack", ">= 5.2.4.3" # CVE-2020-8166
gem "activestorage", ">= 5.2.4.3" # CVE-2020-8162
gem "activesupport", ">= 5.2.4.3" # CVE-2020-8165
gem "actionview", ">= 5.2.4.3" # CVE-2020-8167
gem "pg", "~> 1.1.4"
gem "puma", ">= 4.3.5" # GHSA-w64w-qqph-5gxm
gem "rack", ">= 2.2.3" # CVE-2020-8184
gem "rails", "~> 5.2.3"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "websocket-extensions", ">= 0.1.5" # GHSA-g6wq-qcwm-j5g2

# third-party gems
gem "annotate"
gem "bootsnap", ">= 1.1.0", require: false
gem "bootstrap", "~> 4.3.1"
gem "coffee-rails", "~> 4.2"
gem "data_migrate", "~> 5.3.2"
gem "devise", ">= 4.7.1"
gem "draper", "~> 3.0.1"
gem "humanize", "~> 2.1.1"
gem "jbuilder", "~> 2.5"
gem "jquery-rails"
gem "nokogiri", ">= 1.10.8" # CVE-2020-7595
gem "rack-mini-profiler", require: false
gem "turbolinks", "~> 5"

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "dotenv-rails"
  gem "factory_bot_rails", "~> 5.0.2"
  gem "ffaker"
  gem "simplecov", require: false
end

group :development do
  gem "flamegraph"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "memory_profiler"
  gem "pry"
  gem "solargraph", require: false
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "stackprof"
  gem "web-console", ">= 3.3.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "chromedriver-helper"
  gem "selenium-webdriver"
end
