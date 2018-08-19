# README

Things you may want to cover:

* System dependencies

* Configuration

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# Canary Application README

This is the appliation for a mock social media platform

## License

## Getting Started

To get started with the app, clone the repo and then install the needed gems:

ruby '2.3.3'
'rails', '~> 5.2.0'
'sqlite3' 								# Active-Record database
'puma', '~> 3.11' 				# App server
'sass-rails', '~> 5.0'		# SCSS stylesheets
'uglifier', '>= 1.3.0'		# JavaScript compressor
'duktape'
'coffee-rails', '~> 4.2'
'turbolinks', '~> 5'
'jbuilder', '~> 2.5'

---
$ bundle install --without production
---

Next, migrate the database

---
$ rails db:migrate
---

Finally, run the test suite to verify that everything is working correctly:

---
$ rails test
---

If the test suite passes, you'll be ready to run the app in a local server:

---
$ rails server
---

For more information, see ...