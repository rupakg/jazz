# Ruby API project template

The project template includes boilerplate code that will kickstart your development using Ruby, building serverless API functions.

## Built-in features

* Basic API Lambda function code template with tests
* Dependency management for external components (gems via bundler)
* Configuration management
* Logging support

## Build

The Gemfile contains the dependencies for the project. Modify it to add your own dependencies. Then run `bundle install` to install the dependencies.

## Tests

Run tests by running:

```
$ ruby -I test test/handler_test.rb
```