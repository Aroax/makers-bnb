## Makers BnB

Built a web application that allows users to list spaces they have available, and to hire spaces for day(s) (Airbnb clone).

#### Main features

- Users can sign-up and sign-in - [Registration](/screenshots/register-form.png) / [Login](/screenshots/login-form.png) 
- Login credentials are validated - [Login](/screenshots/login-validation.png) 
- Spaces exist, and are displayed on home page - [Home page](/screenshots/landing-page.png) 
- Space has a name, a blurb, a price (all provided by Host)
- Host can list a space - [New space form](/screenshots/new-space-form.png) 
- Host can list multiple spaces - [User's spaces](/screenshots/my-spaces.png)
- Space has availability (by Host)
- User can request a space for date(s)
- User can see availability; User cannot book an unavailable space - [Registration](/screenshots/space-unavailable-alert.png) 
- Host can approve/decline space requests - [User dashboard](/screenshots/user-dashboard.png) 
- Space is available until request is approved - [Booking table](/screenshots/booking-requests.png)

<img src="/screenshots/landing-page.png" width="70%" alt="home page">

### Entity Relationship Diagram

![Entity Relationship Diagram](/screenshots/ERD.png)

### Tech

- Sinatra (Ruby)
- PostgreSQL
- HTML, CSS (Bootstrap)
- RSpec (unit testing)
- Capybara (feature testing)
- TablePlus (Database GUI)

### How to

#### Set up the project

Clone this repository and install all the dependencies by running:

```
bundle install
```

To set up the databases, connect to psql:

```
psql
```

Create the `makers_bnb` and `makers_bnb_test` databases:

```
CREATE DATABASE makers_bnb;
CREATE DATABASE makers_bnb_test;
```

Connect to each database:
```
\c makers_bnb;
\c makers_bnb_test;
```
To create the tables, run the SQL queries in the `db/migrations` folder in the given order.

#### Run the app

- run ``` ruby app.rb ```
- Visit http://localhost:4567/

### User stories

```
As a User
So that I can make bookings
I would like to be able to register for an account

As a Host
So I can have more guests
I would like to be able to list multiple Spaces

As a Host
So I can manage my Spaces
I would like each Space to have availability

As a User
So I can decide where to book
I would like to see a Space’s availability

As a Host
So I can manage my guests
I would like to be able to approve or deny a request

As a User
To manage my high expectations
I would like to only be able to request available Spaces

As a Host
So I can manage my guests
I would like to continue receiving requests until I approve one

```

### Team

- [Arran](https://github.com/aroax)
- [Irina](https://github.com/IrinaGC)
- [Juel](https://github.com/Juel07)
- [Mike](https://github.com/mjconn)

### Instructions/Help for Team

#### Database Queries
- the DatabaseConnection object should automatically connect to our test dbs (hopefully)
- query from other objects by using:
`DatabaseConnection.query(sql: "SQL string here querying parameter $1 WHERE $2 = whatever", params: [param1, param2] )`

#### RSpec focus
- You can optionally add `, :focus` before the do..end block of any rspec unit describe (including multiple tests) to 
  focus in on particular tests, e.g.
  ```
  describe '.add', :focus do
    tests here
   end
  ```
- you can add as many :focus points as you like, it will include each one with that tag
-  => just remember to delete the `, :focus` when you're done please, so it doesn't get committed to main!
