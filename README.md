# README

Built with Ruby 2.4.0 and Rails 5.0.2

Depends on:
 * MySQL – general database
 * Sphinx – fulltext search engine
 * ImageMagik – image processing libraries
 * Redis – as adapter for Action Cable

### Links
 * [http://crossover.habrapp.ru](https://github.com/markdown-it/markdown-it) – Demo application `admin@crossover.com` or `support@crossover.com` with password `123123123`
 * [https://github.com/storuky/crossover](https://github.com/storuky/crossover) – Github repository

### How to install
1. If you are using RVM you should install ruby-2.4.0 and create project gemset
2. Clone `config/database.yml.example` to `config/database.yml` and fill it with your database settings
3. Restore from `db/dump.sql` or if you need the initial app you should run `rake db:create db:migrate`
4. Start Sphinx and re-index the data using `rake ts:rebuild`

### Feedback
Good assignment. Not so simple, not so difficult.