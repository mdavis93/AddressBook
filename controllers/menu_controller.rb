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
    puts "5 - Exit"
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
      puts "Good-Bye!"
      exit(0)
    else
      system "clear"
      puts "Sorry, that is not a valid input"
      main_menu
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
    system "clear"
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
    print "Search By Name: "
    name = gets.chomp
    match = address_book.binary_search(name)
    system "clear"

    if match
      puts match.to_s
      search_submenu(match)
    else
      puts "No Match Found For #{name}"
    end
  end

  def read_csv
    print "Enter CSV file to import: "
    file_name = gets.chomp

    if file_name.empty?
      system "clear"
      puts "No CSV file read"
      main_menu
    end

    begin
      entry_count = address_book.import_from_csv(file_name).count
      system "clear"
      puts "#{entry_count} new entries added from #{file_name}"
    rescue
      puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
      read_csv
    end
  end

  def search_submenu(entry)
    puts "\nd - Delete Entry"
    puts "e - Edit Entry"
    puts "m - Main Menu"

    selection = gets.chomp
    case selection
    when "d"
      system "clear"
      delete_entry(entry)
      main_menu
    when "e"
      edit_entry(entry)
      system "clear"
      main_menu
    when "m"
      system "clear"
      main_menu
    else
      system "clear"
      puts "#{selection} is not a valid input"
      puts entry.to_s
      search_submenu(entry)
    end
  end

  def entry_submenu(entry)
    puts "n - Next Entry"
    puts "d - Delete Entry"
    puts "e - Edit Entry"
    puts "m - Return to Main Menu"

    selection = gets.chomp

    case selection
    when "n"
      delete_entry(entry)
    when "d"
    when "e"
      edit_entry(entry)
      entry_submenu(entry)
    when "m"
      system "clear"
      main_menu
    else
      system "clear"
      puts "#{selection} is not a valid input"
      entry_submenu
    end
  end

  def edit_entry(entry)
    print "Updated Name: "
    name = gets.chomp
    print "Updated Phone Number: "
    phone = gets.chomp
    print "Updated Email: "
    email = gets.chomp
    entry.name = name if !name.empty?
    entry.phone_number = phone if !phone.empty?
    entry.email = email if !email.empty?
    system "clear"
    puts entry
  end

  def delete_entry(entry)
    address_book.entries.delete(entry)
    puts "#{entry.name} has been deleted."
  end
end
