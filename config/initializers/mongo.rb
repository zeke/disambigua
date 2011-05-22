if ENV['MONGOHQ_URL']
  MongoMapper.config = {RAILS_ENV => {'uri' => ENV['MONGOHQ_URL']}}
  MongoMapper.connect(RAILS_ENV)
else
  MongoMapper.database = "disambigua_#{Rails.env}"
  # MongoMapper.config = {RAILS_ENV => {'uri' => "mongodb://localhost/disambigua_#{Rails.env}"}}
end

