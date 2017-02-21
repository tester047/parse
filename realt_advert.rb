require 'open-uri'
require 'nokogiri'
require 'json'

showings = []

# dyn_url = 'http://realt.by/sale/flats/object/1024929/'
dyn_url = 'http://realt.by/sale/flats/object/1005959/'
url = dyn_url
# html = open(url)
# doc = Nokogiri::HTML(html)
doc = Nokogiri::HTML(open(url, 'User-Agent' => 'mozilla'))
title = doc.css('h1').text
  # Contact Information table
date = doc.xpath('//*[@id="c1030"]/div/table[1]/tbody/tr[1]/td[2]').text
phone = doc.xpath('//*[@id="c1030"]/div/table[1]/tbody/tr[2]/td[2]/div[2]/strong/nobr/a').text
e_mail = doc.xpath('//*[@id="c1030"]/div/table[1]/tbody/tr[3]/td[2]').text
person = doc.xpath('//*[@id="c1030"]/div/table[1]/tbody/tr[4]/td[2]').text
  # Location table
region = doc.xpath('//*[@id="c1030"]/div/table[2]/tbody/tr[1]/td[2]/a').text.split(' ').first
locality = doc.xpath('//*[@id="c1030"]/div/table[2]/tbody/tr[2]/td[2]/a/strong').text
# address = doc.xpath('//*[@id="c1030"]/div/table[2]/tbody/tr[3]/td[2]').text.gsub('Информация о доме', '').strip
street = doc.xpath('//*[@id="c1030"]/div/table[2]/tbody/tr[3]/td[2]/a').text
house_number = doc.xpath('//*[@id="c1030"]/div/table[2]/tbody/tr[3]/td[2]/text()').text.split(' ').last
district = doc.xpath('//*[@id="c1030"]/div/table[2]/tbody/tr[4]/td[2]/a[1]').text.split(' ').first
microdistrict = doc.xpath('//*[@id="c1030"]/div/table[2]/tbody/tr[4]/td[2]/a[2]').text
  # Paramets table
rooms_all = doc.xpath('//*[@id="c1030"]/div/table[3]/tbody/tr[1]/td[2]/div[2]/strong').text.split('/').first.strip
rooms_separate = doc.xpath('//*[@id="c1030"]/div/table[3]/tbody/tr[1]/td[2]/div[2]/strong').text.split('/').last.strip
floor = doc.xpath('//*[@id="c1030"]/div/table[3]/tbody/tr[2]/td[2]').text.split('/').first.strip
number_of_floors = doc.xpath('//*[@id="c1030"]/div/table[3]/tbody/tr[2]/td[2]').text.split('/').last.strip
type_of_floor = doc.xpath('//*[@id="c1030"]/div/table[3]/tbody/tr[3]/td[2]').text
type_of_house = doc.xpath('//*[@id="c1030"]/div/table[3]/tbody/tr[4]/td[2]').text
#room_space_all = doc.xpath('//*[@id="c1030"]/div/table[3]/tbody/tr[5]/td[2]/strong').text.split('/').first.strip
#room_space_living = doc.xpath('//*[@id="c1030"]/div/table[3]/tbody/tr[5]/td[2]/strong').text.split('/')[1].strip
# room_space_kitchen = doc.xpath('//*[@id="c1030"]/div/table[3]/tbody/tr[5]/td[2]/strong').text.split('/').last.strip.to_f
#room_space_kitchen = doc.xpath('//*[@id="c1030"]/div/table[3]/tbody/tr[5]/td[2]/strong').text.split('/').last.split(' ').first
#layout = doc.xpath('//*[@id="c1030"]/div/table[3]/tbody/tr[6]/td[2]').text
ceiling_height = doc.xpath('//*[@id="c1030"]/div/table[3]/tbody/tr[7]/td[2]').text.to_f
 # = doc.xpath('').text



showings.push(
  Title: title,
  Date: date,
  Phone: phone,
  E_mail: e_mail,
  Person: person,
  Region: region,
  Locality: locality,
  Street: street,
  House_number: house_number,
  District: district,
  Microdistrict: microdistrict,
  Rooms_all: rooms_all,
  Rooms_separate: rooms_separate,
  Floor: floor,
  Number_of_floors: number_of_floors,
  Type_of_floor: number_of_floors,
  Type_of_house: type_of_house,
  # Room_space_all: room_space_all,
  # Room_space_living: room_space_living,
  # Room_space_kitchen: room_space_kitchen,
  # Layout: layout,
  Ceiling_height: ceiling_height
)

puts JSON.pretty_generate(showings)