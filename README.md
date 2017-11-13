# Comfy Demo App

This is a simple demo app that has ComfortableMexicanSofa installed, configured
and extended. You should be able to recreate everything by creating a fresh
Rails app and following these steps.

### Step 1. Installation.

* Add required gems to [Gemfile](https://github.com/comfy/comfy-demo/blob/master/Gemfile#L59)
* Run `rails active_storage:install` to pull in ActiveStorage migration
* Run `rails g comfy:cms` to pull in CMS migration, routes and initializer
* Run migrations: `rake db:migrate`
* Start the server: `rails s`
* Navigate to http://localhost:3000/admin
* Log in with default credentials: u: `username`, p: `password`

### Step 2. Hello World.

* Create a Site. Comfy is a multi-site capable CMS, but for now we only need to
  worry about one. Put "Demo" as a **Label** and **Indentifier** should
  auto-populate to "demo". Site will be created and you'll be redirected to
  the Layout creation view.
* Let's create a Layout. Set **Layout Name** to "main". **Identifier** should
  auto-populate. Leave **Content** populated with `{{cms::wysiwyg content}}`.
  This just indicates that pages using this layout will have a single text field
  via Wysiwyg HTML editor. Don't worry about **Stylesheet** and **Javascript**
  just yet. After creating your first Layout navigate to **Pages** section via
  sidebar navigation.
* Now we'll create landing page. Set **Label** to "Homepage", populate some text
  like "Hello World" in the **Content** field and hit **Create Page**.
* Now you have some content that's ready to be served. Navigate to
  http://localhost:3000/ and you should see your text.

### Step 3. Basic Configuration.

* Open `/config/initializers/comfortable_mexican_sofa.rb` and change default
  username and password. This initializer allows to configure things that are
  relevant to your app. You may utilize authentication provided by Device or
  whatever you may have in your app. This is the place to set this up.

### Step 4. TODO
