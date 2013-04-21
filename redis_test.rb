require "redis"
require "json"

# 接続
puts "■ 接続"
# p redis = Redis.new(:host => "XXX.XXX.XXX.XXX", :port => 6379)
p redis = Redis.new(:host => "localhost", :port => 6379)
puts ""

# 単純なKey Valueの例
puts "■ 単純なKey Valueの例"
p redis.set "86", "toyota"
p redis.set "BRZ", "subaru"
p redis.get "86"
p redis.get "BRZ"
puts ""

# インクリメントの例
puts "■ インクリメントの例"
puts "1をセット"
p redis.set "data:int", "1"
p redis.get "data:int"
puts "インクリメント"
p redis.incr "data:int"
p redis.get "data:int"
puts "10を加算"
p redis.incrby "data:int", 10
p redis.get "data:int"
puts ""

# Listの例
puts "■ Listの例"
puts "右から順番に3個追加する。"
p redis.rpush "maker", "toyota"
p redis.rpush "maker", "subaru"
p redis.rpush "maker", "mitsubishi motors"
puts "左の先頭から3個表示する。"
p redis.lrange "maker", 0, 2
puts "左から数えて2番目から2個表示する。"
p redis.lrange "maker", 1, 2
puts "左から1個追加する。"
p redis.lpush "maker", "mazda"
puts "左の先頭から3個表示する。"
p redis.lrange "maker", 0, 2
puts ""

# Setsの例
puts "■ Setsの例"
puts "値をセット"
p redis.sadd "vehicle", "elan"
p redis.sadd "vehicle", "esprit"
p redis.sadd "vehicle", "elite"
puts "中身は？"
p redis.smembers "vehicle"
puts ""

# Sorted setsの例
puts "■ Sorted setsの例"
puts "値をセット"
p redis.zadd "maker2", 1953, "subaru"
p redis.zadd "maker2", 1920, "mazda"
p redis.zadd "maker2", 1937, "toyota"
puts "中身は？"
p redis.zrange "maker2", 0, -1
puts "降順で表示"
p redis.zrevrange "maker2", 0, -1
puts ""


# JSON
puts "■ JSONの例"
jsontest = {id:1, name:"watashi", time:Time.now, body:"jsontest"}
puts "値をセット"
p redis.set "json_1", jsontest.to_json
puts "中身は？"
p JSON.parse(redis.get("json_1"))
puts ""

# 全キーの削除
puts "■ 全キーの削除"
p redis.flushdb
puts ""

# 切断
puts "■ 切断"
p redis.quit
puts ""

# 再度接続
redis = Redis.new(:host => "localhost", :port => 6379)

# シャットダウン
p redis.shutdown


