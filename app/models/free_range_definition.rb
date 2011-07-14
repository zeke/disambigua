class FreeRangeDefinition
  include MongoMapper::EmbeddedDocument

  key :body, String, :required => true
  key :page_url, String, :required => true
  key :page_title, String, :required => true
end