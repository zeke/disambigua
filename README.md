disambigua
==========

Disambigua is a Wikipedia disambiguation/translation JSON webservice.

**Note**: This project is no longer maintained. Its translation functionality has been replaced by [ord.zeke.xxx](http://.zeke.xxx), a simpler node.js app which is also open source and available at [github.com/zeke/ord](https://github.com/zeke/ord).

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
