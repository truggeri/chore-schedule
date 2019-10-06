# Chore Schedule

![Coverage badge](https://img.shields.io/badge/coverage-92%25-brightgreen.svg)

An app for making and keeping a chore schedule. See it hosted at [https://www.choreplanfor.us](https://www.choreplanfor.us)

## About the Application

This app is focused on household chores. Users can create chores, assign them a frequency in days, weeks or months 
and "perform" them to reset the next due clock. They can assign chores into custom categories as well.

## About Development

This app is written with Ruby on Rails. It was originally written to prove a fast proof-of-concept, but has since been
 refactored to follow better patterns such as [Draper Decorators](https://github.com/drapergem/draper), 
 [MiniTest](https://guides.rubyonrails.org/testing.html) unit tests, seeds, and 
 [Factory Bot factories](https://github.com/thoughtbot/factory_bot_rails). It is currently in a stable state. 
 
## Running

```bash
bundle install
bundle exec rails server
```

## Tests

The test suite includes unit test for logic in models, helpers and decorators. It also includes some integration tests
that exercise basic functionality in the controller logic. These tests aims to test many common paths that 
produces high test coverage, but this is not guarantee that the testing is exhaustive.

```bash
bundle exec rails test
```
