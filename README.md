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
```
add some html to your `views/index.erb` file
```html
<h1>Hello!</h1>
```
