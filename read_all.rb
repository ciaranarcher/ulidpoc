require 'mysql2'

db_host = "localhost"
db_user = "root"
db_name = 'biz'

client = Mysql2::Client.new(host: db_host, username: db_user, database: db_name)

puts "reading back all widgets, LIMIT 100"
results = client.query("SELECT ULID_ENCODE(id) AS id, name FROM `widgets` LIMIT 100;")

puts "read #{results.size} results"
results.each do |row|
  puts row["id"] + "|" + row["name"]
end
