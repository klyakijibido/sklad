# README

rails _6.1.7.4_ new sklad  -d sqlite3 --skip-sprockets --skip-spring --skip-listen --skip-turbolinks --skip-jbuilder -T --skip-bootsnap

* steps:
rails g model Provider name full_name
rails g model Country name
rails g model Plant name
rails g model ProductType name
rails g model Product name art razd sor price:decimal price_buy:decimal code:integer provider:references country:references plant:references ean13

rails g model Shop name
rails g model DiscountCard name
rails g model User name




be rails g scaffold_controller tovar show index
rails db:migrate

bundle exec rails g model user name email
bundle exec rails g scaffold_controller user

rails g migration AddTovarTypeToTovars tovar_type:references
rails g migration AddPlantToTovars plant:references
rails g migration AddProviderToTovars provider:references

