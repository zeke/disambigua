class Translation
  include MongoMapper::EmbeddedDocument

  key :name, String, :required => true
  key :language_code, String, :required => true
  key :language_name, String, :required => true
end