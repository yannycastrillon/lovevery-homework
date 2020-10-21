# Lovevery Take Home Project

This is the take-home project for engineers at Lovevery, and thanks in advance for taking the time on this.  The
goal of this project is to try to simulate some real-world work you'll do as an engineer for us, so that we can
see you write some code from the comfort of your own computer.

## The Gift Feature

The basic flow is:

1. Visit `/` and see the products
1. Select a product to view it or click directly on the **Give Gift** button
   - Inside of the product you will also be able to click on **Give Gift**
1. Fill in the data needed to give a gift away:
   - **Gifter Information**
      - First Name
      - Last Name
      - Email
   - **Child's Information**
      - Full Name
      - Birthdate
      - Parent Name
   - **Credit Card Information**
      - Card Number
      - Expiration Month
      - Expiration Year
   - **Message**
      - An optional text to be attach to the gift.
1. Click **purchase gift** to give away that product.
1. This will create an order in our system, it will find or create a new gifter and lastly it will create a gift record in our database.

### Important things to consider: 
   1. Child MUST already exist on our system.
      - This means that an **ORDER** must had been purchased in the past with the child's information.
   1. **Full name, Birthdate** and **Parent Name** values must strictly match the ones in our system.
   1. **Address** and **Zipcode** are obtained from Child's last registered order.
   1. **Credit Card information** must be valid.


## Getting Set Up

   Assuming you have Ruby installed and are using a Ruby version manager like rvm or rbenv, you should be able to:

   ```
   > bin/setup
   > bin/rspec
   ```

   This should install needed gems, set up your databases, and then run the tests, which should all be green and pass.


## Running the app

   Run the following command to spin up the server:

   ```
   > rails server
   ```
   Then go to your browser: `localhost:3000` and the app should be up and running.


## Heroku Deploment 

https://lovevery-app.herokuapp.com/

## Notes About The Code
I followed a TDD approach to overcome and tackle this **Gift** feature.

### Models
I created 3 new models (_Gift, Gifter and OderGift_).
1. **Gifter** => It holds all the person's data providing the gift.
1. **Gift** => It is the model's main feature because it wires everything up between [Gifter, Product, Child and Order].
1. **OrderGift** => It is responsible for associating the order with a gift.
   - _An order can have many gifts but a single gift can only have one order_ => Solid idea on how I approached this feature :D .
   
### Services
You will also find a couple of **services** that are in charge of very specific responsibility from the bussiness logic.
1. **SearchChildService** => Responsible of finding a child base on their full name, birthdate and parent name.
1. **SearchGifterService** => Responsible of finding or creating a gifter.
1. **CreateOrderService** => Responsible of creating the order and calling the Purchase service.
1. **BuildGiftService** => Responsible of _Orchestrating_ all the above services. It also returns a gift instance to the controller so it can be save in our system.

#### _I believe service objects follow 3 principles_
1. They all contain a single public interface method `call`.
2. They focus on a specific task from the bussines logic.
3. They return either `failure` or `success`. If it is a `success` then it should return the proper `instance object` to be save/update in database.
   To follow this pattern strategy I created 2 POROs (Plain Old Ruby Objects) `Success` and `Failure` to encapsulate custom exceptions and responses from each service object. Additionally, I opted to delegate the `Exceptions handling` responsibility to `ApplicationController` because it's the common place where all controllers inherit from, and a centralize place to catch each exception and render them.

### RSpec
   You will find must all of the new models, controllers and services to have tests around their functionalities and edge cases.
   Each Model, Service and Controller will have their proper `xxxx_spec.rb` file.
   I also apply `factories` to be able to mock model data and build the testing proper scenarios.
