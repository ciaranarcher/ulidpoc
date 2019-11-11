# Working with ULIDs

A simple POC to demonstrate creating [ULIDs](https://github.com/ulid/spec) as part of a Rails application (in the `rails_example` sub-directory) and reading them back in plain Ruby.

## Setup

* Run `bundle`
* Create a local MySQL database called `biz`.
* Connect to MySQL and run the contents of the `schema.sql` file to create a `widgets` table.

## Inserting data

Change to the `rails_example` directory:

* `bundle`
* `bundle exec rails console`

Create a few rows:

```ruby
Widget.create(account_id: 99, name: 'test_from_rails', created_at: Time.now)
```

You'll notice the [ULID ActiveRecord gem](https://github.com/k2nr/ulid-rails) will create and assign a ULID ID to each model.

## Reading data with Rails

You can read them back like so:

```ruby
id = Widget.last.id

Widget.find(id) # => #<Widget id: "1DSD3VD20HESRZHP5TKER27BK", row_num: 62, account_id: 99, ...>
```

## Reading data without Rails

You can also read the rows back using a special user-defined MySQL function as defined in `ulid_fn.sql` ([original credit](https://gist.github.com/kenji4569/47ce8bbd6bef7b85ba1f97e018f34cf3)) by running:

```bash
bundle exec ruby read_all.rb

reading back all widgets, LIMIT 100
read 2 results
01DSD3RFGQ8VK4T5GN99J2HR9G|test_from_rails
01DSD3VD20HESRZHP5TKER27BK|test_from_rails
```

Or lookup an individual row like so:

```bash
bundle exec ruby read_one.rb 01DSD3VD20HESRZHP5TKER27BK

reading back 01DSD3VD20HESRZHP5TKER27BK
read 1 results
01DSD3VD20HESRZHP5TKER27BK|test_from_rails
```

## Gotchas

ULIDs are 26 characters long and Base32 encoded. You'll notice that Rails will drop any leading '0' characters, but knows at save / read time to pad the string again.

So for example, an ID returned by Rails might be `1DSD3VD20HESRZHP5TKER27BK` (25 characters). However, if you use this out of band, i.e. you copy it from a log file and try to lookup the value you won't find a record. The correct value should be`01DSD3VD20HESRZHP5TKER27BK` (26 characters; note the leading `0`).
