# Week 3 Review: SQL & Sinatra
This week, we are going to review some SQL concepts, and some web concepts, using Sinatra.  
  
Let's start out by createing a new directory, and initializing a git repository.
```
mkdir sql_and_sinatra_review
cd sql_and_sinatra_review
git init
git touch README.md
echo "#My Readme" >> README.md
git add README.md
git commit -m "Init Commit: Add README"
```
## SQL Review
[SQLZoo](www.sqlzoo.net) | [SQLFiddle](http://sqlfiddle.com/#!15/5df3a1/2)  
  
Let's start out by [creating a
database](http://www.postgresql.org/docs/9.3/static/app-createdb.html)
with a table called members. And insert 5 members into the table.
```sql
CREATE TABLE members(
  id SERIAL PRIMARY KEY,
  email_address VARCHAR(50) NOT NULL,
  password VARCHAR(50) NOT NULL
);

INSERT INTO members (email_address, password)
  VALUES ('drew@codecore.ca', 'Password123'),
    ('drew_two@codecore.ca', 'Password123'), ('drew_three@codecore.ca', 'Password123')
    ('drew_four@codecore.ca', 'Password123'), ('drew_five@codecore.ca', 'Password123');
```
Now, query the table for all members whose id is greater than two.
```sql
SELECT * FROM members WHERE id > 2;
```
## Sinatra Review
Let's have a review of Sinatra. We covered some web concepts like HTTP Verbs, including GET and POST. Let's continue with the same concepts by creating a list of favorite songs.  
  
Take a moment to think about what we will need, and how we should implement it.  
  
As per convention, let's start with a simple "hello world," to make sure we're set up correctly, then incrementally built out our idea.  
```
# songer.rb
require 'sinatra'

get '/' do
  "<h1>Hello World!</h1>"
end
```
We can then run our app on port 4567 by default, or whichever open port we specify. For example, if we want our app to be available on port 3000 of our localhost, we can run the following:
```
ruby songer.rb -p 3000
```
Now that we are satisfied that we have our machine set up correctly, we can start to develop our task.  
  
Sinatra is expecting a directory named "views" to exist, if you are using html or erb pages. Erb is a way to add ruby code directly into HTML pages.  
  
Let's make that folder, and add in an index and a form to add songs
```
mkdir views
touch views/index.erb
touch views/add_song.erb
```
To make sure we have everything working, before spending too much time developing, let's just add some text, and endpoints to each of these views one at a time.
```
# songer.rb
require 'sinatra'

get '/' do
  erb :index
end

get '/new' do
  erb :add_song
end
```
add some html to your `views/index.erb` file
```html
<!-- views/index.erb -->
<h1>Hello!</h1>
```
Do the same thing for our add song form.
```erb
<!-- views/add_song.erb -->
<h1>Add Song<h1>
<form>
  <input><br>
  <input><br>
  <input><br>
  <input type="submit">
</form>
```
Now that we have multiple pages (even though we only have 2), let's add some navigation. We want all pages going forward to share the same navigation, so it's easier to maintain. We can add a shared layout file.
```
touch views/default_layout.erb
```
```erb
<% # views/default_layout.erb %>
<!DOCTYPE html>

<nav><a href="/">home</a> | <a href="/new">add song</a></nav>

<%= yield %>
```
Now that we have a default layout with navigation, let's modify our `songer.rb` to use it
```ruby
# songer.rb

get '/' do
  erb :index, layout: :default_layout
end

get '/new' do
  erb :add_song, layout: :default_layout
end
```
Let's add some functionality so we can submit input to our form, and save it in a songs key-value store in a session.

let's start by enabling sessions. To do so, simply add `enable :sessions` to our `songer.rb` file.
```ruby
# songer.rb
require 'sinatra'

enable :sessions

get '/' do
  erb :index, layout: :default_layout
end

get '/new' do
  erb :add_song, layout: :default_layout
end
```
Let's revisit our form, and make sure it's doing what we want it to. We want to use it to submit form data and pass a key-value store called params to our `songer.rb`.
```erb
<% # views/add_song.erb %>

<h1>Add Song</h1>

<form method="POST" action="/">
  artist: <input name="artist"><br>
  title: <input name="title"><br>
  video: <input name="video"><br>
  <input type="submit">
</form>
```
Now that we have a params hash available to us, let's redirect back to our index, and (for now) display the params, if there are any.
```ruby
# songer.rb
require 'sinatra'

enable :sessions

get '/' do
  erb :index, layout: :default_layout
end

get '/new' do
  erb :add_song, layout: default_layout
end

post '/' do
  "artist: #{params[:artist]}, title: #{params[:title]}, video: #{params[:video]}"
end
```
Things are going pretty good, so far! Let's go for a home run by storing the params data in a songs hash in the session. We can then use the session songs hash to populate data displayed on the index page.

```ruby
# songer.rb
require 'sinatra'

enable :sessions

get '/' do
  erb :index, layout: :default_layout
end

get '/new' do
  erb :add_song, layout: default_layout
end

post '/' do
  artist = params[:artist]
  title = params[:title]
  video = params[:video]
  session[:songs] = {} unless session[:songs]
  session[:songs][artist] = {title => video}
  erb :index, layout: :default_layout
end
```
Now that we have the data avaiable through our session, let's use it to fill out a table on our index page that looks something like this:
  
artist | title
--- | ---
White Rabbits | [Heavy Metal](https://www.youtube.com/watch?v=OQ7Bc-nrplw)
