---
tags: ruby, sinatra, routes, kids, forms, html
languages: ruby, html
level: 3
---

How does Twitter post your tweets? How does facebook upload your photos? How does tumblr air your most secret guilty pleasures? All of these web applications take in information from a user, mutate that information, and then display it back. We’re going to teach you guys how to do this with forms.

+ First let’s create an HTML form in your view. Forms are kind of like an envelope that holds information that we are sending from the front end of our application (where a user is typing information in the browser) to the back end where our models modify and store info.

+ This envelope is created with form tags that have two 
attributes called `action` and `method`. Standard form tags look like this:

```html
<form action="/tweets" method="POST">
  <!-we'll be adding input fields here in a minute-->
</form>
```

+ This action corresponds to a route in our controller. This form is set up to send input to a '/tweets' route via a POST request. (We'll be using this form to create some tweets.)

+ We've already learned about GET requests. We use GET requests when the browser is getting information from the server (like the HTML/CSS for a web page). 

+ This time around we want to send information the other way - from our browser back to the server - or from the front end of our application to the back (from the view to the model). To do this we'll use the Sinatra post method and set up a post route in our controller like so:

```ruby
post '/tweets' do
  # we'll be adding code to process input from our form here
end
```

+ Now our form is set up to send info from the user to the right place in our application, but our form “envelope” is empty. We need to create fields to take in info from the user and we use <input> tags to do this. They look something like this:

```html
<form action="/tweets" method="POST">
  <input type="text" name="username">
  <input type="text" name="status">
  <input type="submit">
</form>
```
+ Notice that these input tags have two important attributes: `type` and `name`. There are lots of choices for the `type` of input field (drop down menu, radio button, check box) but we are going to start with an open text field for this demo by setting `type="text"`. 

+ Notice we've also included an input tag with `type="submit"`. This is VERY important because it creates a submit button and our users can't submit anything without it.

+ The other attribute in our input tags, `name`, is like a label to describe the information we are taking in. It is extremely important for keeping track of the information that is submitted.

+ When a user hits the submit button a ton of information is sent from the browser back to the server (front end to back end). It looks a little like this:




This is what happens:
https://drive.google.com/a/flatironschool.com/file/d/0B4vrcPO5UdhRd29oSE00bDBJU3c/view?usp=sharing 
This is where we tip our hats to Sinatra. It takes all of this and distills the important info down to a hash that is called a params hash. 
Why “params” hash? Params is short for parameters. 
Information can also be passed from from browser to server (or the frontend to the back end of an application) via URL parameters. Dying to know more about that? Check out the “Dig Deeper” <is this what we were planning to call them?> section on Ironboard.  
Let’s take a look at this params hash by adding params.inspect into our post ‘/tweets’ route.
Now we’ve got our params hash with all of the pertinent info to create a new instance of our tweet. Where does that happen? In the controller.
How do we create a new instance of a tweet? How can pull out info from the params hash to do this? Give it a shot!

So great, we’ve got a form with a submit button, but when we hit submit, Sinatra tells us that it doesn’t know this ditty. 
We need to add some instructions for Sinatra in our post ‘/tweets’ route so it knows what to do next. But where did all of the info from our form go? And how do we get a hold of it? 


What happens when you hit submit? Nada. We’re not providing anything for our browser to display in this post ‘/tweets’ method. Hmmmm wouldn’t it be nice if we had a route that displayed all of the tweets we created. Wait a minute we do!
Sinatra has a handy little method called redirect that will send our browser to ‘/tweets’ - thus calling our get ‘/tweets’ method and displaying our tweets.
WE’VE GOT TWEETS PEOPLE!!!!
