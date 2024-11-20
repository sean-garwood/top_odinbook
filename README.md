# Odinbook

A mock social media website built to the specification of [the final
project](https://www.theodinproject.com/lessons/ruby-on-rails-rails-final-project)
of The Odin Project's Ruby on Rails course.

## Assignment

Build a social media site! You’ll build a large portion of the core user functionality of your chosen site in this project. You don’t have to worry about some of the more flashy front-end stuff unless you want to, but you don’t need it to get a nice user experience.

You should write at least a basic set of integration tests which let you know if each page is loading properly and unit tests to make sure your associations have been properly set up (e.g. testing that `User.first.posts` works properly). Run them continuously in the background with Guard (See the Ruby on Rails Tutorial Chapter 3.7.3).

This project will give you a chance to take a relatively high level set of requirements and turn it into a functioning website. You’ll need to read through the documentation on GitHub for some of the gems you’ll be using.

### Specifications

Keep the following requirements in mind. We’ll cover specific steps to get
started below this list:

#### done

1. Use PostgreSQL for your database from the beginning (not SQLite3), that way your deployment will go much more smoothly.
1. Users must sign in to see anything except the sign in page.
1. User sign-in should use the Devise gem. Devise gives you all sorts of helpful methods so you no longer have to write your own user passwords, sessions, and `#current_user` methods. See the Railscast on Devise (which uses Rails 3) for a step-by-step introduction. The docs will be fully current.
1. Users can send follow requests to other users.
1. Users can create posts (begin with text only).
1. Users can like posts.
1. Users can comment on posts.
1. Posts should always display the post content, author, comments, and likes.
1. Users can create a profile with a profile picture. You may be able to get the profile picture when users sign in using OmniAuth. If this isn’t the case you can use Gravatar to generate the photo.
1. A user’s profile page should contain their profile information, profile photo, and posts.
1. There should be an index page for users, which shows all users and buttons for sending follow requests to users the user is not already following or have a pending request.
1. There should be an index page for posts, which shows all the recent posts from the current user and users they are following.
1. Set up a mailer to send a welcome email when a new user signs up. Use the Letter Opener gem to test it in development mode.

#### todo

1. Deploy your App to a hosting provider.
1. Set up an email provider and start sending real emails.
1. (NOT SPECIFIED, BUT NICE TO HAVE) Allow users to view and accept friend
   requests. This could be done on the views/requests/index.html.erb with
   embedded buttons

##### Extra credit

1. Make posts also allow images (either just via a URL or, more complicated, by uploading one).
1. Use Active Storage to allow users to upload a photo to their profile.
1. Make your post able to be either a text OR a photo by using a polymorphic association (so users can still like or comment on it while being none-the-wiser).
1. Style it up nicely! We’ll dive into HTML/CSS in the next course.
1. (not specified, but cool) Use turbo frames to avoid rendering entire pages

### Getting started

1. Think through the data architecture required to make this work. There are a lot of models and a lot of associations, so take the time to plan out your approach.
1. Build the new PostgreSQL Rails app `$ rails new odinbook --database=postgresql`, initialize the Git repo and update the README to link back to this page.
1. Work your way down the list above! Each step will involve a new challenge but you’ve got the tools.
1. You can populate data like users and posts using the Faker gem, which is basically just a library of sample names and emails. It may just be easier, though, for you to write your own seeds in the `db/seeds.rb` file, which gets run if you type `$ rake db:seed`.

### Final step

Before you move on, we would love it if you could send us your feedback on the
Ruby on Rails course. Getting user (you) feedback is important so we can
continue to improve the curriculum and get an idea of your experience.
