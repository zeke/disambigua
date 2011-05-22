if ENV['MONGOHQ_URL']
  # MongoMapper.config = {RAILS_ENV => {'uri' => ENV['MONGOHQ_URL']}}
  # MongoMapper.connect(RAILS_ENV)
  # MONGOHQ_URL => mongodb://heroku:4qk2s5zrl8xc8plu9fjxyw@flame.mongohq.com:27098/app537968

  user = "heroku"
  password = '4qk2s5zrl8xc8plu9fjxyw'
  host = 'flame.mongohq.com'
  port = '27098'
  db_name = 'app537968'

  MongoMapper.connection = Mongo::Connection.new(host, port, :auto_reconnect => true)
  MongoMapper.database = db_name
  MongoMapper.database.authenticate(user, password)
else
  MongoMapper.database = "disambigua_#{Rails.env}"
  # MongoMapper.config = {RAILS_ENV => {'uri' => "mongodb://localhost/disambigua_#{Rails.env}"}}
end

