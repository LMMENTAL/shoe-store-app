#copy data from inventory and add to dB, add latitude and longitude

SHOE_STORES = [
  ['ALDO Centre Eaton', 45.500640600365934, -73.57264759165082],
  ['ALDO Destiny USA Mall', 43.06724905087377, -76.17089647491485],
  ['ALDO Pheasant Lane Mall', 42.70122678653728, -71.43737897597066],
  ['ALDO Holyoke Mall', 42.16802383926408, -72.64202742546806],
  ['ALDO Maine Mall', 43.63372699156617, -70.33444254604903],
  ['ALDO Crossgates Mall', 42.68917860494669, -73.84887175774448],
  ['ALDO Burlington Mall', 42.48144924579992, -71.21424835960386],
  ['ALDO Solomon Pond Mall', 42.35616386557414, -71.61294548121374],
  ['ALDO Auburn Mall', 42.25599903231538, -71.80359327127414],
  ['ALDO Waterloo Premium Outlets', 42.95639285346104, -76.92052421040938]
]
SHOE_MODELS = [
  'ADERI',
  'MIRIRA',
  'CAELAN',
  'BUTAUD',
  'SCHOOLER',
  'SODANO',
  'MCTYRE',
  'CADAUDIA',
  'RASIEN',
  'WUMA',
  'GRELIDIEN',
  'CADEVEN',
  'SEVIDE',
  'ELOILLAN',
  'BEODA',
  'VENDOGNUS',
  'ABOEN',
  'ALALIWEN',
  'GREG',
  'BOZZA'
]
VALUES = Array(0..100)

SHOE_STORES.each{ |store| Store.create!(name: store[0], latitude: store[1], longitude: store[2]) }
SHOE_MODELS.each do |shoe|
  Shoe.create!(name: shoe, cost: VALUES.sample)
end

Store.pluck(:id).each do |store_id|
  Shoe.pluck(:id).each do |shoe_id|
    Inventory.create!(store_id: store_id, product_id: shoe_id, count: VALUES.sample)
  end
end

# Reset alerts for purpose of demo
Alert.destroy_all