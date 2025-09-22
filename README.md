# Line of Credit Test

This is a take-home test project that validates line of credit functionality through automated web testing. The test suite uses Ruby/RSpec with Capybara for web automation to verify draw/payment transactions and interest calculations.

## Framework Organization

- **`spec/features/`** - Feature tests for line of credit scenarios
- **`spec/support/features/session_helpers.rb`** - Helper methods for web interactions and calculations
- **`spec/spec_helper.rb`** - Test configuration and Capybara setup
- **`.env`** - Environment variables (BASE_URL for target application)

## Setup

### Install Ruby Manager & Ruby

Either [rbenv](https://github.com/sstephenson/rbenv) or [RVM](http://rvm.io/rvm/install) should work just fine.

    ❯ rbenv install 3.3.2
    ❯ rbenv gemset create 3.3.2 line_of_credit_test
    ❯ rbenv gemset active

### Install Dependencies

    gem install bundler
    bundle install

### Run Tests

    bundle exec rspec ./spec/features

or...

    rake os_x_10_11_chrome_58