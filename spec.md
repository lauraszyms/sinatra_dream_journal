# Specifications for the Sinatra Assessment

Specs:
- [x] Use Sinatra to build the app - Inherits from Sinatra::Base
- [x] Use ActiveRecord for storing information in a database - Used ActiveRecord for my migrations/db
- [x] Include more than one model class (list of model class names e.g. User, Post, Category) - User and dreams models
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Posts)- User has many dreams
- [x] Include user accounts - Users log in and out to create dreams
- [x] Ensure that users can't modify content created by other users - Users must be logged in and content must belong to them
- [x] Ensure that the belongs_to resource has routes for Creating, Reading, Updating and Destroying- User can read, create, update, and delete their dreams.
- [x] Include user input validations - Must enter valid username and password
- [x] Display validation failures to user with error message (example form URL e.g. /posts/new)- error message if trying to log in without valid info.
- [x] Your README.md includes a short description, install instructions, a contributors guide and a link to the license for your code

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
