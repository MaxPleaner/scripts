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

Two main features were added in this iteration. TeamNote now supports user accounts, enabling login/logout, and access to notes is now restricted to the user who created them. 
When a user first visits TeamNote, they will be prompted to login or signup before they can create a note or view their own notes. To signup, users enter in their username, email address, password, and password confirmation. To log in, users enter their email address and password. After an account is created, they may create, view, edit or delete their notes as in 2.1; however, they may only do so for notes that they created, and may not access notes of other users.

To support this functionality, a Sessions controller and a Users model & controller was added. The Notes controller was also modified to restrict users' access to their own notes. 

Login/logout:

The User model contains fields for first name, last name, username, email, and password. When a User is first created, 


A Sessions controller handles log in and logout requests, delegating authentication to a 

Access control:

The Application controller was modified to check that the User is logged in before accessing any part of the TeamNote application (with exceptions for the signup and login/logout pages). A require_login method is called before each attempted access, and will redirect the user to login if necessary. 

In addition, the Notes controller was modified to support user permissions. A validate_user method is called before each attempted access to a Note, and checks if the user_id associated with the Note matches the user_id of the user that is logged in. If the user is not authorized, the user will be shown a message indicating they do not have access, and redirected to their Notepad page (listing all of their own notes). I put validate_user in the Notes controller instead of the Application controller because it was more specific to Notes. If it had been in Application, I would have needed to carve out exceptions for it in the session login/signup pages as well. 


To support this functionality, a User model and a Sessions controller was added.

Design challenges:

During this iteration, many design challenges arose unexpectedly. It turns out there's a lot of details that go into creating the seamless login/logout user experience we are accustomed to on the broader Internet!

One major design decision was to handle the authentication of users from scratch. Though I was aware of the has_secure_password option explained in class, which would automatically handle password hashing with a password_digest, I decided to implement my own. I recognize that in the real world one would never happen (and I probably won't do this for future projects in this class) but I wanted to fully understand how it worked. 

When a User is first created, the User controller 

To do this, the User controller has a authenticate method that validates that 

- Auto login after signup
- How to make notes private
- How to implement authentication - did by hand to understand how it would work. 

