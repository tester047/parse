require 'open-uri'
require 'nokogiri'
require 'json'

showings = []

#dyn_url = 'http://realt.by/sale/flats/object/1024929/'
#dyn_url = 'http://realt.by/sale/flats/object/1005959/'
dyn_url = ['http://realt.by/sale/flats/object/1005959/', 'http://realt.by/sale/flats/object/1024929/']
dyn_url.each do |url|
  #url = dyn_url
  doc = Nokogiri::HTML(open(url, 'User-Agent' => 'mozilla'))

  td_arr = []
  doc.css('td.table-row-left').each {|x| td_arr.push(x.text)}

  td_hash = {}
  td_arr.each do |x|
    #puts "#{x}: #{doc.at("td:contains('#{x}')").path}"
    td_path = doc.at("td:contains('#{x}')").path
    td_num = td_path[/td\[[0-9]\]/].split('')[-2].to_i+1
    td_value_path = td_path.gsub(/td\[[0-9]\]/){|s| "td[#{td_num}]"}
    td_value = doc.xpath(td_value_path).text
    td_hash[x] = td_value
  end

  #td_hash.each {|key, value| puts "#{key}: #{value}"}
  td_hash.each {|key, value| showings.push("#{key}": value)}
end

#puts showings
puts JSON.pretty_generate(showings)


#test_path = doc.at('td:contains("Тип дома")').path
#td_num = test_path[/td\[[0-9]\]/].split('')[-2].to_i+1
#td_value_path = test_path.gsub(/td\[[0-9]\]/){|s| "td[#{td_num}]"}
#doc.xpath(td_value_path).text

 # парсинг Ориентировочной стоимости. только цифры
#doc.xpath('//*[@id="c1030"]/div/table[4]/tbody/tr[3]/td[2]/div[2]/strong/span[1]').text.split(',').last.gsub(/\D/, '')
#doc.xpath('//*[@id="c1030"]/div/table[4]/tbody/tr[3]/td[2]/div[2]/strong/span[1]').text.split(',').first.gsub(/\D/, '')