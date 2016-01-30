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
