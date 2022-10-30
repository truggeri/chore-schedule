source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.0"

gem "actionpack", ">= 6.1.3.2" # CVE-2021-22903
gem "actionview", ">= 5.2.4.3" # CVE-2020-8167
gem "activerecord", ">= 5.2.4.5" # CVE-2021-22880
gem "activestorage", ">= 5.2.4.3" # CVE-2020-8162
gem "activesupport", ">= 5.2.4.3" # CVE-2020-8165
# gem "kramdown", ">= 2.3.1" # CVE-2021-28834
gem "pg", "~> 1.1.4"
gem "puma", ">= 4.3.5" # GHSA-w64w-qqph-5gxm
gem "rack", ">= 2.2.3" # CVE-2020-8184
gem "rails", "~> 7.0.4"
gem "sassc-rails", "~> 2.1.2"
gem "uglifier", ">= 1.3.0"

# third-party gems
gem "annotate"
gem "bootsnap", ">= 1.7.3", require: false
gem "devise", ">= 4.7.1"
gem "draper"
gem "humanize", "~> 2.1.1"
gem "jbuilder", "~> 2.5"
gem "nokogiri", ">= 1.10.8" # CVE-2020-7595
gem "rack-mini-profiler", require: false
gem "rexml", ">= 3.2.5" # CVE-2021-28965

group :development, :test do
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "dotenv-rails"
  gem "factory_bot_rails", "~> 5.0.2"
  gem "ffaker"
  gem "rubocop"
  gem "rubocop-rails"
  gem "simplecov", require: false
end

group :development do
  gem "flamegraph"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "memory_profiler"
  gem "pry"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "stackprof"
  gem "web-console", ">= 3.3.0"
end
