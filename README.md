disambigua
==========

Disambigua is a Wikipedia disambiguation/translation webservice. It RESTfully serves up JSON.

Examples
--------

- [/terms/bat/disambiguations](http://disambigua.heroku.com/terms/bat/disambiguations)
- [/terms/cat/translation](http://disambigua.heroku.com/terms/cat/translations)
- [/terms/James%20Brown/disambigua](http://disambigua.heroku.com/terms/James%20Brown/disambiguations)

Guts
----

- Rails 3.1 PRE
- MongoHQ and mongo_mapper
- edge rspec and factory_girl
- mechanize/nokogiri for wikipedia parsing