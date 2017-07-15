# Customer Support App
A sample app for Ruby on Rails and AngularJS stack

## Architecture

### Back-end
The Back-end of the application is a Ruby on Rails API. The API is based on the REST architecture and responds with JSON. The API follows the standard MVC design pattern.

## Installation
The app consists of Ruby on Rails back-end and AngularJS front-end

### Back-end
Installation links for various dependencies are provided:
* [Ruby](https://www.ruby-lang.org/en/documentation/installation/)
* [Rails](http://guides.railsgirls.com/install#setup-for-linux)
* [MySQL](https://www.tutorialspoint.com/mysql/mysql-installation.htm)

After installing Rails and MySQL, execute the following command in project_root/
```
bundle install
```

## Initialization
Run the following the command to initialize the database
```
rails db:setup
```

## Test
Most of the test-coverage of the app is through end-to-end tests implemented
with Capybara. Some back-end unit-tests are also implemented with RSpec. To run
them, execute the following command in project_root/
```
rspec spec/
```

## Running the app
Open `localhost:3000` to view the app