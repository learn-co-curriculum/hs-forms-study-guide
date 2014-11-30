---
tags: ruby, sinatra, routes, kids, forms, html
languages: ruby, html
level: 3
---

##Using Forms

**There is a solution to the following walk-through in the `demo` directory. Please feel free to create your own directory and follow along.**

How does Twitter post your tweets? How does facebook upload your photos? How does tumblr air your most secret guilty pleasures? All of these web applications take in information from a user, mutate that information, and then display it back. We’re going to teach you guys how to do this with forms.

Forms are kind of like an envelope that holds information that we are sending from the front end of our application (where a user is typing information in the browser) to the back end where our models modify and store info. 

This envelope is created with form tags that have two attributes called `action` and `method`. A standard form tag looks like this:

```html
<form action="/tweets" method="POST">
  <!--we'll be adding input fields here in a minute-->
</form>
```

The `action` corresponds to a route in the application controller. The `method` indicates how this info should be sent. The form tag above is set to send input to a '/tweets' route via a POST request. Let's break this down a little bit more.

We've already learned about GET requests. We use GET requests when the browser is getting information from the server (like the HTML/CSS for a web page). 

+ This time around we want to send information the other way - from our browser back to the server - or from the front end of our application (the view) to the back end (the model). To do this we'll use the Sinatra post method and set up a post route in our controller like so:

```ruby
post '/tweets' do
  # we'll be adding code to process input from our form here
end
```

Now our form is set up to send info from the user to the right place in our application, but our form “envelope” is empty. We need to create fields to take in info from the user and we use `<input>` tags to do this. They look something like this:

```html
<form action="/tweets" method="POST">
  <input type="text" name="username">
  <input type="text" name="status">
  <input type="submit">
</form>
```
Notice that these input tags have two important attributes: `type` and `name`. There are lots of choices for the `type` of input field (drop down menu, radio button, check box) but we are going to start with an open text field for this demo by setting `type="text"`. 

The other attribute in our input tags, `name`, is like a label to describe the information we are taking in. It is extremely important for keeping track of what is being submitted.

Notice we've also included an input tag with `type="submit"`. This is VERY important because it creates a submit button. Our users can't submit anything without it.

When a user hits the submit button a ton of information is sent from the browser back to the server. It looks something like this:

![img](https://dl.dropboxusercontent.com/u/3026743/form-data.jpg)

Which looks a little scary. Here is where we tip our hats to Sinatra. Our Sinatra application takes all of this crazy code, pulls out the important pieces

![img](https://dl.dropboxusercontent.com/u/3026743/form-data-highlighted.jpg)

and distills the important info down to a hash that is called params and looks something like this:

```ruby
{"username"=>"withloudhands", "email"=>"bob@flatironschool"}
```

The keys in the hash are set in the forms `name=` attributes and the values in the hash are set with the values that a user types into the form. Like this:

![img](https://dl.dropboxusercontent.com/u/3026743/params.hash.jpg)

Why is this hash called “params”? It's convention but its also because information can be passed from from browser to server (or the frontend of an application to the back end) via URL parameters. Dying to know more about that? Check out the Forms Demo on Ironboard. 

Now let's take a look at the params hash that Sinatra creates with the input from our tweets form. You can always check out your params hash by replacing any code you have in your POST route with `params.inspect`. This will display the params hash in your browser when you hit the submit button and it can be **very helpful for debugging**. Our params hash for this form looks something like this:

```ruby
{"username"=>"Vanessa", "status"=>"My first tweet!!!"}
```

This params hash is just like any old ruby hash with key value pairs. If we want to pull out the value "Vanessa" from the hash, how do we do that? With something like this:

```ruby
params[:username]
```

Notice that we are using the symbol `:username`. Although the keys in our params hash appear as strings when we do `params.inspect`, it is best practice to refer to the keys using a symbol and this will work just fine in your application.

Now we’ve got our params hash with all of the pertinent info we need to create a new tweet, but where is this info headed? (Hint: We set this destination with the `action` and `method` attributes of our form.) That's right. It's headed to our `post ‘/tweets’` route, so we'll need to add some instructions for Sinatra in that method.

The rest of this walk-through relies on having a Tweet model already in place. Check out `/models/tweet.rb` in the demo to see the model we'll be working with to build tweets. 

We're going to use this Tweets model to create a new instance of a tweet in the controller. Notice that we have included `require_relative 'models/tweet.rb'` at the top of `application_controller.rb` - a very important step in making sure the code in `application_controller.rb` has access to the code in `tweet.rb`. 

Creating a new instance of a Tweet in the controller looks like this:

```ruby
post '/tweets' do
  Tweet.new(params[:username], params[:status])
  redirect '/tweets'
end
```

Notice that the two arguments that we are feeding into the initialize (.new) method are the username ("Vanessa") and the status ("My first tweet!!!") from the params hash. 

The next line after we've created our new tweet is `redirect('/tweets')`. Sinatra has a handy little method called redirect that takes in a route as an argument. We are redirecting to the `get ‘/tweets’` method (which displays our `tweets.erb` template in the browser). If you had another route like `get '/home'` you could redirect to the home page instead with `redirect('/home')`.

As long as this `redirect` method is in the last line of our `post '/tweets'` route and the `get '/tweets'` method is set up properly with an erb template to display the tweets this should go swimmingly.

So every time a user fills out the form to create a new tweet and hits the submit button the following steps will take place:

1. a params hash with info from the form will be sent to the `post '/tweets'` method 
2. inside `post '/tweets'` the `Tweet.new` method is called and a new instance of the Tweet class is created with info from the params hash (and the new Tweet instance is added to an `ALL_TWEETS` array)
4. the `redirect('/tweets')` method is called which triggers the `get '/tweets'` method/route
5. inside `get '/tweets'` the `Tweet.all` method is called and an array of tweets is stored in an `@tweets` instance variable
6. the `erb(:tweets)` is called, the `@tweets` array is sent to the `tweets.erb` template where we've set up embedded ruby to iterate through the `@tweets` array and display each tweet
7. the `tweets.erb` template with the new tweet is rendered and displayed in the browser

PHEW! That was a lot of steps, but now WE’VE GOT TWEETS!!!!

Try out the demo we've included in this walk-through by moving into the `demo` directory and starting up the server with the `rackup` command in your terminal. Then go to `localhost:9292/tweets` in your browser to see the form and start submitting your own tweets. **You must be in the demo directory and you must use `rackup` NOT `shotgun` for this demo to work properly.** 

