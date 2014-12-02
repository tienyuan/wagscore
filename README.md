## WagScore

Description
======================
This is an locator app that shows places to take your dog around town.
We're also going to show you the *WagScore*, which is the dog friendliness of an area.

Made with my mentor, [Eliot Sykes](https://www.bloc.io/mentors/eliot-sykes) at Bloc.

Visit a working copy at [wagscore](http://wagscore.herokuapp.com/).
Try searching for 'UCLA' or 'Cal State LA' within '2 miles'.

Features
======================
* You can search for an area and results are shown and mapped.
* A score is calculated for search results based on existing categories.
* Visitors can submit new locations or flag existing locations for review.
* Administrators can review and manage locations.


Gems include:
* figaro
* geocoder
* gmaps4rails
* devise
* pundit


Setup
======================
Clone this repository. 

Then copy `config/application.example.yml` to `application.yml` and add values. 

These are the same environment settings needed in production.

```
SENDGRID_USERNAME: 
SENDGRID_PASSWORD: 

development:
  SECRET_KEY_BASE: 
  DATABASE_USERNAME: 
  DATABASE_PASSWORD: 

test:
  SECRET_KEY_BASE: 
  DATABASE_USERNAME: 
  DATABASE_PASSWORD:

```

Run `bundle install` to install all relevant gems.

Run `rspec/spec` to test the application.


Screenshots
====================

![Home Page](http://tienyuan.github.io/wagscore/img/home.png)
![When You Search](http://tienyuan.github.io/wagscore/img/search.png)
![Submission Page](http://tienyuan.github.io/wagscore/img/submission.png)
