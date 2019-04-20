require_relative 'controllers/menu_controller'
require 'record_manager'

RecordManager.connect_to('db/address_book.db', :sqlite)

menu = MenuController.new
system "clear"
puts "Welcome To AddressBook!"
menu.main_menu
