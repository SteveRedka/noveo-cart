# Noveo cart

Demo cart API.

[Live on heroku](https://noveo-cart.herokuapp.com/api/products)

## Prequesites
* Ruby 2.4.1
* bundler

## Setup
```
git clone git@github.com:SteveRedka/noveo-cart.git
cd noveo-cart
bundle install
rake db:setup
rails s
```

## Deploy
```
git push heroku master
heroku rake db:schema:load
heroku rake db:seed
```

## Notes
APIs should be versioned. If specs didn't say otherwise, I'd put carts into `api/v1/carts` group.

https://blog.mwaysolutions.com/2014/06/05/10-best-practices-for-better-restful-api/
