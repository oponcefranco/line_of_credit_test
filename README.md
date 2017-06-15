# Line of Credit Test
Fair Take Home Exercise

### Install Ruby Manager & Ruby

Using  [RVM](http://rvm.io/rvm/install) but [rbenv](https://github.com/sstephenson/rbenv) should work just fine.

    rvm install ruby-2.3.0
    rvm use --create ruby-2.3.0@fair
    rvm --ruby-version use ruby-2.3.0@fair

## Application Setup
### Bundle Up

    gem install bundler
    bundle install

### Run tests

    bundle exec rspec ./spec/features
or...

    rake os_x_10_11_chrome_58