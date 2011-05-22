class Term
  include MongoMapper::Document

   key :name, String, :required => true
   # key :age,  Integer

   many :disambiguations

   def wikified_name
     wn = self.name.slice(0,1).capitalize + self.name.slice(1..-1) # capitalize first letter
     wn.gsub(/ /, '_') # replace spaces with underscores
  end
   
end
