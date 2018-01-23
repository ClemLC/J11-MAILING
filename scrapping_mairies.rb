
require 'nokogiri'
require 'open-uri'

$city = []# on créé une array avec un $ pour le nom des villes
$email = []# la même pour les adresses emails

def get_all_the_urls_of_val_doise_townhalls (web_list)
  page = Nokogiri::HTML(open(web_list))
  $is = 1
  page.css("a.lientxt").each do |url|
    url['href'] = url['href'][1..-1]
    web_page = "http://annuaire-des-mairies.com" + url['href']
    $city[$is]= url.text

    get_the_email_of_a_townhal_from_its_webpage(web_page)
  end
end

def get_the_email_of_a_townhal_from_its_webpage (web_page)
  doc = Nokogiri::HTML(open(web_page))
    doc.xpath('//p[@class = "Style22"]').each do |mail|
   if mail.text.include?("@")
     $email[$is] = mail.text.gsub(/[[:space:]]/,'')#permet de virer le maudit espace qui s'incruste devant l'adresse mail
     $is +=1
     mail.text
    end
  end
end

get_all_the_urls_of_val_doise_townhalls("http://www.annuaire-des-mairies.com/essonne.html")

require 'google_drive'
require 'json'


session = GoogleDrive::Session.from_config("config.json")
ws = session.spreadsheet_by_key("1ZK0KlAl4uaVxgx7OoafAxQB_aeWh2W1wogMGOSa_hzE").worksheets[0]

ws[1, 1] = "ville"#je nomme les en-têtes de colonnes du spreadsheet
ws[1, 2] = "mail"

for j in (2..$city.length-1) do
  ws[j, 1] = $city[j]
   ws[j, 2] = $email[j]
   ws.save
 end
