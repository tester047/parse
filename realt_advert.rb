require 'open-uri'
require 'nokogiri'
require 'json'

showings = []

dyn_url = 'http://realt.by/sale/flats/object/1024929/'
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
  Microdistrict: microdistrict
)

puts JSON.pretty_generate(showings)