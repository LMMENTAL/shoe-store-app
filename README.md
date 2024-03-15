# Setup

## App Configuration
- bundle install
- rake db:migrate
- rake db:seed

## Run Localhost Server
- rails s

## Run Websocket Server
websocketd --port=8080 ruby non_random_inventory.rb

## Run Singleton To Parse Data Stream
- rails c
- InventoryDataParser.instance

## Monitor at http://localhost:3000/
- *The id (e.g. 9-1) is to make it easier to see which alert message corresponds with which Inventory message.*

## Clear Alerts before a test
- rails c
- Alert.destroy_all

# Design

- Websocket server and demo initiated by running to simulate incoming inventory updates from stores: websocketd --port=8080 ruby non_random_inventory.rb
- Singleton instance to parse websocket payloads and update inventory records.
- Rails Observer callback for Inventory object will check if Inventory drops below a set threshold and create an alert after finding the nearest store with sufficient inventory.
- live_alerts partial polls GET /alerts endpoint for new entries to insert into top of FE list. If any alerts are dropped because of polling a page refresh can get all alerts.
- On page refresh the alerts tab will fetch all alerts ordered by the stores whose closest inventories are farthest away, colour coding them in levels based on the nearest log value of the distance away in km.

# Scaling Considerations/Potential Improvements

- Horizontal scaling of websocket servers with a load balancer to handle traffic.
- Implement a CDN for different availaibility zones.
- Load shedding and auto scaling considerations during bursts of traffic.
- Implementation of a pub/sub system to use as message broker such as kafka/rabbitmq in place of websocket.
- Add models for Users with specific roles and Accounts for access control as parent objects of stores.
- Secure app for users using authentication and authorization schemes.
- Add papertrail to product model to audit inventory for saleskeeping.
- Move Urls and other sensitive values to ENV Variables.
- Adding more product types.
- Adding RSpec Coverage.
- Analyzing and optimizing the nearest_store algorithm or using Google Maps API to find closest by driving distance.
- Having Warehouse objects replace nearest store suggestions.