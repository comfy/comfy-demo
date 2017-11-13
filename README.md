# Comfy Demo App

This is a simple demo app that has ComfortableMexicanSofa installed, configured
and extended. You should be able to recreate everything by creating a fresh
Rails app and following these steps.

### Step 1:

* Add required gems in [Gemfile](todo)
* Run `rails active_storage:install` to pull in ActiveStorage migration
* Run `rails g comfy:cms` to pull in CMS migration, routes and initializer
* Run migrations: `rake db:migrate`
* Start the server: `rails s`
* Navigate to http://localhost:3000/admin
* Log in with default credentials: u: `username`, p: `password`

### Step 2:

* TODO
