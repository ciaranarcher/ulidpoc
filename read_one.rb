require 'mysql2'

db_host = "localhost"
db_user = "root"
db_name = 'biz'

client = Mysql2::Client.new(host: db_host, username: db_user, database: db_name)

id = ARGV[0]
if id.nil?
  puts "please pass a valid ULID value"
  exit(1)
end


puts "reading back #{id}"

# # read it back
results = client.query("SELECT ULID_ENCODE(id) AS id, name FROM `widgets` WHERE id = ULID_DECODE('#{id}');")

puts "read #{results.size} results"

results.each do |row|
  puts row["id"] + "|" + row["name"]
end
