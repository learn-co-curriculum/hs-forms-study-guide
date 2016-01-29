

##Using Forms

**There is a solution to the following walk-through in the `demo` directory. Please feel free to create your own directory and follow along.**

How does Twitter post your tweets? How does facebook upload your photos? How does google perform your searches? All of these web applications take in information from a user, mutate that information, and then display something back. We’re going to teach you guys how to do this with forms.

HTML forms are kind of like an envelope that holds information that we are sending from the front end of our application (where a user is typing information in the browser) to the back end where our models modify and/or store info. 

This envelope is created with form tags that have two attributes called `action` and `method`. A standard HTML form tag looks like this:

```html
<form action="/results" method="POST">
  <!--we'll be adding input fields here in a minute-->
</form>
```

The `action` attribute corresponds to a route in the application controller. The `method` indicates how this info should be sent. The form tag above is set to send input to a '/results' route via a POST request. Let's break this down a little bit more.

We've already learned about GET requests. We use GET requests when the browser is *getting* information from the server (like the HTML/CSS for a web page). 

This time around we want to send information the other way - from our browser back to the server - or from the front end of our application (the view) to the back end (the model). To do this we'll use the Sinatra post method and set up a post route in our controller like so:

```ruby
post '/results' do
  # we'll be adding some code here
end
```

Now our form is ready to send info from the user to the right place in our application, but our form “envelope” is empty. We need to create fields for our users to fill in and we use `<input>` tags to do this. Here is our form with a field for a location [that we can send to Foursquare for a search]:

```html
<form action="/resuts" method="POST">
  <input type="text" name="location">
  <input type="submit">
</form>
```
Notice that these input tags have two important attributes: `type` and `name`. There are lots of choices for the `type` of input field (drop down menu, radio button, check box) but we are going to start with an open text field for this demo by setting `type="text"`. 

The other attribute, `name`, is like a label for the information we are taking in. It is extremely important for keeping track of what is being submitted.

Notice we've also included an input tag with `type="submit"`. This is VERY important because it creates a submit button. Our users can't submit anything without it.

When a user hits the submit button a ton of information is sent from the browser back to the server. It looks something like this:

![img](https://dl.dropboxusercontent.com/u/3026743/form-data.jpg)

Which looks a little scary. Here is where we tip our hats to Sinatra. Our Sinatra application takes all of this crazy code and pulls out the important pieces

![img](https://dl.dropboxusercontent.com/u/3026743/form-data-highlighted.jpg)

and distills the important info down to a hash that is called a `params` hash. The keys in the hash come from the `name` attribute and the values in the hash are set by the user when they fill in the form. Like this:

![img](https://dl.dropboxusercontent.com/u/3026743/params.hash.jpg)

Why is this hash called “params”? It's partly just convention but it's also because information can be passed from browser to server (or the front end of an application to the back end) via URL *parameters*. Dying to know more about that? Check out the Forms Demo on Learn. 

Now let's take a look at the `params` hash that Sinatra creates with the input from our tweets form. You can always check out your `params` hash by replacing any code you have in your POST route with `params.inspect`. This will display the params hash in your browser when you hit the submit button and it can be **_very helpful for debugging_**. Our params hash for this form looks something like this:

```ruby
{"location"=>"East Village, New York, NY"}
```

This params hash is just like any old ruby hash with key value pairs. If we want to pull out the value "East Village, New York, NY" from the hash, how do we do that? With something like this:

```ruby
params[:location]
```

Notice that we are using the symbol `:location`. Although the keys in our params hash appear as strings when we do `params.inspect`, it is best practice to refer to the keys using a symbol and this will work just fine in your application.

Now we’ve got our params hash with all of the pertinent info we need for a new Foursquare search, but where is this info headed? (Hint: We set this destination with the `action` and `method` attributes of our form.) That's right. It's headed to our `post ‘/results’` route, so we'll need to add some instructions for Sinatra there.

The rest of this walk-through relies on having a Foursquare model already in place. Check out `/models/foursquare.rb` in the demo to see the model we'll be working with to pull a list of restaurants. 

We're going to use this Foursquare model to create a new instance of a Neighborhood in the controller. Notice that we have included `require './models/foursquare.rb'` at the top of `application_controller.rb` - a very important step in making sure the code in `application_controller.rb` has access to the code in `foursquare.rb`. 

Creating a new instance of a Tweet in the controller looks like this:

```ruby
post '/results' do
  hood = Neighborhood.new(params[:location])
  hood.get_recommended_venues
  @restaurants = hood.recommended_venues
  erb :results
end
```

Notice that the argument that we feed into the initialize (.new) method is the location ("East Village, New York, NY") from the `params` hash. 

The next line after we've created our new tweet is `erb :results` which displays `results.erb` template in the browser. As long as everything is set up properly with an erb template to display the restaurants, this should go swimmingly.

Every time a user fills out the form to search a new neighborhood and hits the submit button the following steps will take place:

1. a params hash with info from the form will be sent to the `post '/results'` route
2. inside `post '/results'` the `Neighborhood.new` method is called and a new instance of the Neighborhood class is created with info from the `params` hash
3. the `get_recommended_venues` method is called to get a list of restaurants
4. the `recommended_venues` array is stored in a `@restaurants` variable
4. the `erb :results` method is called which displays `results.erb` in the browser
5. in `results.erb` you can see embedded ruby that is iterating over the `@restaurants` array and displaying each restaurant name in its own `<p>` tags.

PHEW! That was a lot of steps, but now WE’VE GOT RESTAURANTS!!!!

Try out the demo we've included in this walk-through by moving into the `demo` directory and starting up the server with the `rackup` command in your terminal. Then go to `localhost:9292/` in your browser to see the form and start submitting your own tweets. 

**NB: You must be in the demo directory for this demo to work properly.** 


<p data-visibility='hidden'>View <a href='https://learn.co/lessons/hs-forms-study-guide' title='Using Forms'>Using Forms</a> on Learn.co and start learning to code for free.</p>
