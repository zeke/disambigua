class WikipediaDefinition
  include MongoMapper::EmbeddedDocument

  key :text, String, :required => true
  
  def clean_text
    self.text.strip_tags.gsub(/\[\d+\]/, '')
  end
  
  def as_json(options = {})
    {
      text: self.text,
      clean_text: self.clean_text
    }
  end
  
end