# ValidateMe

ValidateMe offers common sense validations for your ActiveRecord models. Since it relies on different ActiveRecord abstractions it is database agnostic.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'validate_me'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install validate_me

## Usage

Usage is simple, just add `include ::ValidateMe` to whichever ActiveRecord models you would like to have the built-in validations that will match your database constraints.

```ruby
class User < ApplicationRecord
  include ::ValidateMe
end
```

## What is validated?

ValidateMe will validate null constraints, uniqueness (including scope), and limits. See the below examples for more details

Example migration:

```ruby
  create_table :users do |t|
    t.string :first_name, limit: 10, null: false
    t.string :last_name, null: false
    t.string :email, null: false, index: { unique: true }
    t.integer :phone_number, limit: 1
  end
```

The following validations will be added to your model:

```ruby
validates :first_name, presence: true
validates :last_name,  presence: true
validates :email,      presence: true

validates :first_name, length: { maximum: 10 }
validates :phone_number, numericality: { greater_than: -127, less_than: 127 }, allow_nil: true

validates :email, uniqueness: true
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lollar/validate_me. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the ValidateMe project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/lollar/validate_me/blob/master/CODE_OF_CONDUCT.md).
