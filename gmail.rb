# puts "email :"
# username = gets.chomp
# puts "password ?"
# password = gets.chomp

require 'gmail'
require 'gmail_xoauth'
require 'mail'

gmail = Gmail.connect("anthokerlizou@gmail.com", "Roscoff29")

Gmail.connect("anthokerlizou@gmail.com", "Roscoff29") do |mail|
  gmail.logged_in?
end

p gmail

gmail.deliver do
  to "breizhsurfer@hotmail.fr"
  subject "Hello, you bitch !"
  text_part do
    body "You owe me five bucks asshole !"
  end
  html_part do
    content_type 'text/html; charset=UTF-8'
    body "<p>Text of the <em>html</em> message.</p>"
  end
end
