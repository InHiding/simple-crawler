# SimpleCrawler

This is a very simple web crawler with the intent of expore a single domain, no cross domain or subdomain scans happen, a list all static assets(images, javascript, stylesheets) for each page.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple_crawler'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install simple_crawler

If you use [rbenv](https://github.com/rbenv/rbenv) you may need to run `rbenv rehash` after gem installation.

## Usage

Simple call the crawler from command line passing the domain you want to explore

```bash
$ simple_crawler http://www.example.org 
```

For more options run:

```bash
$ simple_crawler -h 
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/simple_crawler.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

