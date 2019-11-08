require 'mysql2'
require 'ulid'

db_host = "localhost"
db_user = "root"
db_name = 'biz'

client = Mysql2::Client.new(host: db_host, username: db_user, database: db_name)

puts "record ULID:" + id = ULID.generate

client.query("INSERT into `widgets` (`id`, `name`, `account_id`) VALUES (ULID_DECODE('#{id}'), 'test', 100)")

results = client.query("SELECT ULID_ENCODE(id) as id, name, account_id FROM `widgets` WHERE id = ULID_DECODE('#{id}')")

puts "results:"
results.each do |row|
  puts row["id"] + "|" + row["name"]
end
