# Line of Credit Test
Take Home Exercise

### Install Ruby Manager & Ruby

Either [rbenv](https://github.com/sstephenson/rbenv) or [RVM](http://rvm.io/rvm/install) should work just fine.

    ❯ rbenv install 3.3.2
    ❯ rbenv gemset create 3.3.2 line_of_credit_test
    ❯ rbenv gemset active

## Application Setup
### Bundle Up

    gem install bundler
    bundle install

### Run tests

    bundle exec rspec ./spec/features
or...

    rake os_x_10_11_chrome_58