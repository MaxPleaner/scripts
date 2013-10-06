# TeamNote 2.1

+ Full Name: Deborah Chen
+ Github Tree Url:
+ Heroku Url:


Features:

The goal of the TeamNote app is to allow users to keep track of tasks and their progress. To support basic functionality, a basic CRUD scaffolding was used. There is one Note model, which contains string fields for the notes's title, description and priority. Users may create, update, and delete, and view a note. They can also view all existing notes on a page, or a Notepad. Each note is stored in a database and may be retrieved at any time. 

The user starts at a landing page that asks if she would like to view all existing notes, or create a new note. 

Other comments:

I used Bootstrap for styling. There are some outstanding styling issues, such as the spacing between buttons, but these will be fixed in the next iteration. 


===

# TeamNote 2.2

Heroku Url: http://floating-temple-6591.herokuapp.com/

Features:

Two main features were added in this iteration. TeamNote now supports user accounts, and notes are now private to the users who created them. When a user first accesses the home page of the site, they are prompted to either sign in or sign up. 

Design challenges:

During this iteration, many design challenges arose unexpectedly. It turns out there's a lot of details that go into creating the seamless login/logout user experience we are accustomed to on the broader Internet!

- Auto login after signup
- How to make notes private
- How to implement authentication - did by hand to understand how it would work. 
