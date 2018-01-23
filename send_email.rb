require 'google_drive'
require 'json'
require 'gmail'
require 'gmail_xoauth'
require 'mail'

puts "what's your mail ?"
username = gets.chomp
puts "password ?"
password = gets.chomp

session = GoogleDrive::Session.from_config("config.json")
ws = session.spreadsheet_by_key("1ZK0KlAl4uaVxgx7OoafAxQB_aeWh2W1wogMGOSa_hzE").worksheets[0]

gmail = Gmail.connect(username, password)

Gmail.connect(username, password) do |mail|
  gmail.logged_in?
end

p gmail #je m'assure d'être connecté à mon compte


for i in(2..191) do
sleep(60) if i%5==0  #attendre 1 minutes tous les 5 mails envoyés
mails = ws[i,2] #je viens chercher l'email
townhall_name = ws[i,1] #je prends le nom de la commune

  email = gmail.compose do
    to mails
    subject "Municipalité de #{townhall_name}" #je mets le nom de la municipalité dans l'objet pour faire péter le taux d'ouverture
    body "Bonjour,
Je m'appelle Manon, je suis élève à une formation de code gratuite, ouverte à tous, sans restriction géographique, ni restriction de niveau. La formation s'appelle The Hacking Project (http://thehackingproject.org/). Nous apprenons l'informatique via la méthode du peer-learning : nous faisons des projets concrets qui nous sont assignés tous les jours, sur lesquel nous planchons en petites équipes autonomes. Le projet du jour est d'envoyer des emails à nos élus locaux pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation gratuite.

Nous vous contactons pour vous parler du projet, et vous dire que vous pouvez ouvrir une cellule à #{townhall_name}, où vous pouvez former gratuitement 6 personnes (ou plus), qu'elles soient débutantes, ou confirmées. Le modèle d'éducation de The Hacking Project n'a pas de limite en terme de nombre de moussaillons (c'est comme cela que l'on appelle les élèves), donc nous serions ravis de travailler avec #{townhall_name} !

Charles, co-fondateur de The Hacking Project pourra répondre à toutes vos questions : 06.95.46.60.80

Bien à vous,

Manon du Faouët"
end
gmail.deliver(email)
end

gmail.logout
