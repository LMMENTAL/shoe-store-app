#!/usr/bin/ruby

require 'json'
require 'date'

STDOUT.sync = true

SHOE_STORES = ['ALDO Centre Eaton', 'ALDO Destiny USA Mall', 'ALDO Pheasant Lane Mall', 'ALDO Holyoke Mall', 'ALDO Maine Mall', 'ALDO Crossgates Mall', 'ALDO Burlington Mall', 'ALDO Solomon Pond Mall', 'ALDO Auburn Mall', 'ALDO Waterloo Premium Outlets']
SHOES_MODELS = ['ADERI', 'MIRIRA', 'CAELAN', 'BUTAUD', 'SCHOOLER', 'SODANO', 'MCTYRE', 'CADAUDIA', 'RASIEN', 'WUMA', 'GRELIDIEN', 'CADEVEN', 'SEVIDE', 'ELOILLAN', 'BEODA', 'VENDOGNUS', 'ABOEN', 'ALALIWEN', 'GREG', 'BOZZA' ]
INVENTORY = Array(1..25)
RANDOMNESS = Array(1..3)

120.times do |i|

  store_index = i%8
  shoe_index = (3*i+5)%18
  inventory_index = i > 4 ? (i-3)%15 : 20 - i
  times = i%3 + 1

  times.times do |j|
    puts JSON.generate({
      id: "#{i}-#{j}",
      time: DateTime.now,
      store: SHOE_STORES[store_index + j],
      model: SHOES_MODELS[shoe_index + j],
      inventory: INVENTORY[inventory_index + j],
    }, quirks_mode: true)
  end
  sleep 5
end

# NOTE: When I used the original code block provided or similar, since I have two clients for the websocket 
# I was getting different payloads even when comparing against same id. Since randomness was involved, the ith message was never idempotent across both clients. 
# I made a copy of the script and modified it accordingly for cleanliness and ease of tracking the alerts that were triggered.
# I was satisfied with this solution since in a real life scenario the payloads won't be generated randomly.
# Also increased the sleep time so it would be easier to visually track and map the alerts in real time.