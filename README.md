CodE; 
Kol; 
Price; 
Skidka; 
CodOperazii; 
User; 
nDiscountCard; 
kkmSerialNumber4; 
ReadOstatok

0 - Date_Now; 

Date_Now; CodE; Kol; Price; Skidka; CodOperazii; locUin; nDiscountCard; kkmSerialNumber4; ReadOstatok


sklad_db_schema.driwio - сохраняется в гуглдиске


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
rails g model OperationType name multiplier_cash:integer multiplier_quantity:integer
rails g model Operation created:datetime product:references quantity:decimal sale_price:decimal discount_percent:integer operation_type:references user:references shop:references

rails g model DiscoCard name
rails g model CashRegister name
rails g migration AddDetailsToOperation disco_card:references cash_register:references rest_before:decimal

rails g migration RenameCreatedInOperation

rm app/models/discount_card.rb
rails generate migration DropDiscount_cards

rails g model BadProduct description repit:integer

# TODO добавить уникальность по трем полям date_created, product_id, cash_register_id и может маг, т.к. cash_register_id=0 для операций изменения
# нужно сделать для operations индекс уникальности по нескольким колонкам(дата,код,магаз)
rails g migration AddUniqueIndexToOperations
