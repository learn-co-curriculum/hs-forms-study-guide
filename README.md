---
tags: ruby, sinatra, routes, kids, forms, html
languages: ruby, html
level: 3
---

##Using Forms

**There is a solution to the following walk-through in the `demo` directory. Please feel free to create your own directory and follow along.**

How does Twitter post your tweets? How does facebook upload your photos? How does tumblr air your most secret guilty pleasures? All of these web applications take in information from a user, mutate that information, and then display it back. We’re going to teach you guys how to do this with forms.

+ Forms are kind of like an envelope that holds information that we are sending from the front end of our application (where a user is typing information in the browser) to the back end where our models modify and store info. 

+ This envelope is created with form tags that have two attributes called `action` and `method`. Standard form tags look like this:

```html
<form action="/tweets" method="POST">
  <!--we'll be adding input fields here in a minute-->
</form>
```

+ This action corresponds to a route in our controller and this form is set up to send input to a '/tweets' route via a POST request. 

+ We've already learned about GET requests. We use GET requests when the browser is getting information from the server (like the HTML/CSS for a web page). 

+ This time around we want to send information the other way - from our browser back to the server - or from the front end of our application (the view) to the back end (the model). To do this we'll use the Sinatra post method and set up a post route in our controller like so:

```ruby
post '/tweets' do
  # we'll be adding code to process input from our form here
end
```

+ Now our form is set up to send info from the user to the right place in our application, but our form “envelope” is empty. We need to create fields to take in info from the user and we use `<input>` tags to do this. They look something like this:

```html
<form action="/tweets" method="POST">
  <input type="text" name="username">
  <input type="text" name="status">
  <input type="submit">
</form>
```
+ Notice that these input tags have two important attributes: `type` and `name`. There are lots of choices for the `type` of input field (drop down menu, radio button, check box) but we are going to start with an open text field for this demo by setting `type="text"`. 

+ The other attribute in our input tags, `name`, is like a label to describe the information we are taking in. It is extremely important for keeping track of what is being submitted.

+ Notice we've also included an input tag with `type="submit"`. This is VERY important because it creates a submit button. Our users can't submit anything without it.

+ When a user hits the submit button a ton of information is sent from the browser back to the server. It looks a little like this:

![img](https://dl.dropboxusercontent.com/u/3026743/form-data.jpg)

+ Which looks a little scary. Here is where we tip our hats to Sinatra. Our Sinatra application takes all of this crazy code, pulls out the important pieces

![img](highlighted screen shot)

+ and distills the important info down to a hash that is called params that looks something like this:


Why “params” hash? Params is short for parameters. 
Information can also be passed from from browser to server (or the frontend to the back end of an application) via URL parameters. Dying to know more about that? Check out the next Forms Demo section on Ironboard. 

+ Let's take a look at the params hash that Sinatra creates with the input from our form. You can always check this information by replacing any code you have in your POST route with `params.inspect`. This will display the params hash in your browser when you hit the submit button and it can be **very helpful for debugging**. Our params hash for this form looks something like this:

```ruby
{"username"=>"Vanessa", "status"=>"My first tweet!!!"}
```

+ This params hash is just like any old ruby hash with key value pairs. If we want to pull out the value "Vanessa" from the hash, how do we do that? With something like this:

```ruby
params[:username]
```

+ Notice that we are using the symbol `:username`. Although you see the keys as strings when you do `params.inspect` it is best practice to refer to the keys using a symbol and this should work just fine in your application.

+ Now that we’ve got our params hash with all of the pertinent info to create a new tweet, we just need to add some instructions for Sinatra in our `post ‘/tweets’` route so it knows what to do next.

+ Check out the tweet.rb model included in the demo. We are going to work with this model to create a new instance of the tweet in the controller. It's going to look a little something like this:

```ruby
post '/tweets' do
  Tweet.new(params[:username], params[:status])
  redirect '/tweets'
end
```

+ Notice that the two arguments that we are feeding into the initialize (.new) method are the username ("Vanessa") and the status ("My first tweet!!!") from the params hash.

+ Now wouldn’t it be nice if we had an easy way to display all of the tweets we are creating. Wait a minute, we do!

+ Sinatra has a handy little method called redirect that we can add to our `post '/tweets'` method that will automatically redirect to the `get ‘/tweets’` method. As long as the `get '/tweets'` method is set up properly with an erb template to display the tweets this should go swimmingly.

WE’VE GOT TWEETS PEOPLE!!!!

+ Try running the demo 
