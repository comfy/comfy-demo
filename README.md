# Comfy Demo App

This is a simple demo app that has ComfortableMexicanSofa installed, configured
and extended. You should be able to recreate everything by creating a fresh
Rails app and following these steps.

### Step 1: Installation

* Add required gems to [Gemfile](https://github.com/comfy/comfy-demo/blob/master/Gemfile#L59)
* Run `rails active_storage:install` to pull in ActiveStorage migration
* Run `rails g comfy:cms` to pull in CMS migration, routes and initializer
* Run migrations: `rake db:migrate`
* Start the server: `rails s`
* Navigate to http://localhost:3000/admin
* Log in with default credentials: u: `username`, p: `password`

### Step 2: Hello World

Create a Site. Comfy is a multi-site capable CMS, but for now we only need to
worry about one. Put "Demo" as a **Label** and **Indentifier** should
auto-populate to "demo". Site will be created and you'll be redirected to
the Layout creation view.

Let's create a *layout*. Set **Layout Name** to "main". **Identifier** should
auto-populate. Leave **Content** populated with:

```html
{{cms::wysiwyg content}}
```

This just indicates that pages using this layout will have a single text field
via Wysiwyg HTML editor. Don't worry about **Stylesheet** and **Javascript**
just yet. After creating your first Layout navigate to **Pages** section via
sidebar navigation.

Now we'll create landing page. Set **Label** to "Homepage", populate some text
like "Hello World" in the **Content** field and hit **Create Page**.

Now you have some content that's ready to be served. Navigate to
http://localhost:3000/ and you should see your text.

### Step 3: Basic Configuration

Open [/config/initializers/comfortable_mexican_sofa.rb](/config/initializers/comfortable_mexican_sofa.rb)
and change default username and password. This initializer allows to configure
things that are relevant to your app. You may utilize authentication provided by
Device or whatever you may have in your app. This is the place to set this up.

### Step 4: Hello World with Bootstrap 4

While we can put entire html structure of the *page* inside *layout*, let's use
Rails layouts for it: [/app/views/layouts/application.html.erb](/app/views/layouts/application.html.erb)

Now let's set our *layout's* **app_layout** to "application"

Save it and you'll see that "Hello World" is inside Bootstrap container.

### Step 5: @cms_site, @cms_layout and @cms_page

When CMS is rendering content you should be able to access above instance
variables in the layout, helpers and partials.

Right now let's set page html title like this:

```erb
<title><%= @cms_page.present? ? @cms_page.label : "Demo App" %></title>
```

### Step 6: Layout nesting and more Content Tags

Let's update *layout* content with something like this:

```html
<div class="jumbotron">
  <div class="container">
    <h1>{{ cms:text jumbotron-title }}</h1>
    <p>{{ cms:text jumbotron-text }}</p>
  </div>
</div>
<main class="container">
  {{ cms:wysiwyg content }}
</main>
<hr/>
<footer class="container">
  {{ cms:snippet footer }}
</footer>
```

All *pages* using this *layout* will have appropriate form fields rendered in
the admin view.

What if we want to have a similar page markup, but with two columns? You can
actually nest *layouts*. Think of `{{ cms:wywiwyg content }}` (or any format as
long as fragment is named "content") as a conventional `yield` in Rails layouts.

Next step is to create a new *layout* that is a child of the existing one. Name
it "Two Columns". Populate its **content** with something like this:

```html
<div class="row">
  <div class="col-md-6">
    <h2>{{ cms:text left-col-title }}</h2>
    <p>{{ cms:markdown left-col-text }}</p>
  </div>
  <div class="col-md-6">
    <h2>{{ cms:text right-col-title }}</h2>
    <p>{{ cms:markdown right-col-text }}</p>
  </div>
</div>

```

*Pages* using this *layout* will have two column and also jumbotron from the
parent *layout*

Notice the `{{ cms:snippet footer }}`. Snippet is a reusable content that you
populate once and reuse everywhere. Good example would be copyright notice that
needs to be at the bottom of all pages. Just create a *snippet* called "footer"
and populate content with "&copy; Copyright 2017"

### Step 7: Non-renderable Page Fragments and view helpers

There's an option to skip the rendering for some tags. Good example would be
meta tags that need to be rendered in the Rails layout. Let's add one of those
tags. You may place them anywhere in the *layout* content.

```html
{{ cms:text meta-description, render: false }}
```

Now you may access this via `cms_fragment_content` view helper:

```html
<meta name="description" content="<%= cms_fragment_content("meta-description") %>">
```

There are several CMS view helpers you may use in your app:

* `cms_fragment_content` - Raw fragment content
* `cms_fragment_render` - If fragment content contains more tags, you can expand them
* `cms_snippet_content` - Raw snippet content
* `cms_snippet_render` - Use render to expand content with tags

Note: Add `helper Comfy::CmsHelper` to your `ApplicationController` if you
opted out from auto-loading all view helpers everywhere.

### Step 8: CMS Seed Data

Now you know to structure and populate content. However, during development it's
not fun to populate content via admin forms and then doing database dumps and
restores. Never mind the complexity of it if you work in a team of people.

CMS Seed Data allows you to create content in files that can get loaded into
database automatically.

TODO...
