# Chore Schedule

![Coverage badge](https://img.shields.io/badge/coverage-92%25-brightgreen.svg)

An app for making and keeping a chore schedule. See it hosted at [https://choreplan.truggeri.com](https://choreplan.truggeri.com)

## About the Application

This app is focused on household chores. Users can create chores, assign them a frequency in days, weeks or months and "perform" them to reset the next due clock. They can assign chores into custom categories as well.

## About Development

This app is written with Ruby on Rails. It was originally written to prove a fast proof-of-concept, but has since been refactored to follow better patterns such as [Draper Decorators](https://github.com/drapergem/draper), [MiniTest](https://guides.rubyonrails.org/testing.html) unit tests, seeds, and [Factory Bot factories](https://github.com/thoughtbot/factory_bot_rails). It is currently in a stable state.

## Running

```bash
bundle install
bundle exec rails server
```

### Dockerfile

There is an included Dockerfile that installs gems, copies relevant files and does an asset precomile. It doesn't use a mounted volume, so it's not ideal for local development, but it could quickly be modified to do so (this would enable live reloading of your code rather than rebuiding after every change). Build it with,

```bash
docker build --tag chore-schedule-app .
```

You can then run with a command like,

```bash
docker run --rm -p 3000:3000 -it -e DATABASE_URL=xxx chore-schedule-app:latest
```

## Tests

The test suite includes unit test for logic in models, helpers and decorators. It also includes some integration tests that exercise basic functionality in the controller logic. These tests aims to test many common paths that produces high test coverage, but this is not guarantee that the testing is exhaustive.

```bash
bundle exec rails test
```
