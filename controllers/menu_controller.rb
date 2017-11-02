require_relative '../models/address_book'

class MenuController
  attr_reader :address_book

  def initialize
    @address_book = AddressBook.new
  end

  def main_menu
    puts "Main Menu - #{@address_book.entries.count} entries"
    puts "1 - View All Entries"
    puts "2 - Create An Entry"
    puts "3 - Seach For An Entry"
    puts "4 - Import Entries From A CSV"
    puts "5 - View Entry Number n"
    puts "6 - Exit"
    puts "9 - Populate Test Data"
    print "Enter Your Selection: "

    selection = gets.to_i

    case selection
    when 1
      system "clear"
      view_all_entries
      main_menu
    when 2
      system "clear"
      create_entry
      main_menu
    when 3
      system "clear"
      search_entries
      main_menu
    when 4
      system "clear"
      read_csv
      main_menu
    when 5
      system "clear"
      view_by_number
      main_menu
    when 6
      puts "Good-Bye!"
      exit(0)
    when 9
      address_book.add_entry("Michael Davis", "432-858-8827", "mdavis@davis.net")
      address_book.add_entry("Test Dummy", "202-456-1212", "test@tester.com")
      address_book.add_entry("Andy Johnson", "505-883-7577", "ajohnson@jnj.edu")
      system "clear"
      puts "Test Data Created!"
      main_menu
    else
      system "clear"
      puts "Sorry, that is not a valid input"
      main_menu
    end
  end

  def view_by_number
    print "View Which Entry? (1 - #{address_book.entries.count} ['0' to exit])"
    choice = gets

=begin
  #Foraged for this block

  Question:  Is it bad practice to have potential "deep nested" calls like this?
             I noticed a similar thing in the menu, where if the user enters an
             invalid choice, the menu re-calls the menu.  If I chose an Invalid
             menu item 5 times, then the 6the call I chose a valid item, would
             the progam not (eventually) have to unwind from all 6 method calls?
=end
    begin
      choice = Integer(choice)
    rescue ArgumentError
      system "clear"
      puts "Please Enter A Valid Number!"
      view_by_number
    end
=begin
  End of Foraged Block
=end

    case choice.to_i
    when 0
      system "clear"
      main_menu
    else
      unless (choice.to_i >= 0 && choice.to_i <= address_book.entries.count)
        system "clear"
        puts "Invalid Index, Please Choose From Provided Range!"
        view_by_number
      end

      system "clear"
      puts address_book.entries[choice-1].to_s
      entry_submenu(address_book.entries[choice].to_s)
    end

  end

  def view_all_entries
    address_book.entries.each do |entry|
      system "clear"
      puts entry.to_s
      entry_submenu(entry)
    end

    system "clear"
    puts "End of Entries"
  end

  def create_entry
    puts "New AddressBook Entry"
    print "Name: "
    name = gets.chomp
    print "Phone Number: "
    phone = gets.chomp
    print "Email: "
    email = gets.chomp

    address_book.add_entry(name, phone, email)

    system "clear"
    puts "New Entry Created"
  end

  def search_entries
  end

  def read_csv
  end

  def entry_submenu(entry)
    puts "n - Next Entry"
    puts "d - Delete Entry"
    puts "e - Edit Entry"
    puts "m - Return to Main Menu"

    selection = gets.chomp

    case selection
    when "n"
    when "d"
    when "e"
    when "m"
      system "clear"
      main_menu
    else
      system "clear"
      puts "#{selection} is not a valid input"
      entry_submenu(entry)
    end
  end
end
