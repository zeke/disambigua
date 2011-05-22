class Disambiguation
  include MongoMapper::EmbeddedDocument

  key :name, String, :required => true
end
