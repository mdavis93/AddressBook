require_relative '../models/address_book'

class MenuController
  attr_reader :address_book

  def initialize
    @address_book = AddressBook.first
  end

  def main_menu
    puts "Main Menu - #{@address_book.entries.count} entries"
    puts "#{@address_book.name} Address Book Selected\n#{@address_book.entries.count} entries"
    puts '0 - Switch Address Book'
    puts '1 - View All Entries'
    puts '2 - Create An Entry'
    puts '3 - Seach For An Entry By Name'
    puts '4 - Import Entries From A CSV'
    puts '5 - Exit'
    puts '6 - Find By Phone Number'
    print 'Enter Your Selection: '

    selection = gets.to_i

    case selection
    when 0
      system 'clear'
      select_address_book_menu
      main_menu
    when 1
      system 'clear'
      view_all_entries
      main_menu
    when 2
      system 'clear'
      create_entry
      main_menu
    when 3
      system 'clear'
      search_entries
      main_menu
    when 4
      system 'clear'
      read_csv
      main_menu
    when 5
      puts 'Good-Bye!'
      exit(0)
    when 6
      system 'clear'
      find_by_phn
      main_menu
    else
      system 'clear'
      puts 'Sorry, that is not a valid input'
      main_menu
    end
  end

  def select_address_book_menu
    puts 'Select an Address Book:'
    AddressBook.all.each_with_index do |address_book, index|
      puts "#{index} - #{address_book.name}"
    end

    index = gets.chomp.to_i

    @address_book = AddressBook.find(index + 1)
    system 'clear'
    return if @address_book
    puts 'Please select a valid index'
    select_address_book_menu
  end

  def view_all_entries
    @address_book.entries.each do |entry|
      system 'clear'
      puts entry.to_s
      entry_submenu(entry)
    end

    system 'clear'
    puts 'End of Entries'
  end

  def create_entry
    system 'clear'
    puts 'New AddressBook Entry'
    print 'Name: '
    name = gets.chomp
    print 'Phone Number: '
    phone = gets.chomp
    print 'Email: '
    email = gets.chomp

    @address_book.add_entry(name, phone, email)

    system 'clear'
    puts 'New Entry Created'
  end

  def find_by_phn
    print 'Search By Phone Number: '
    number = gets.chomp
    match = @address_book.find_entry(number)
    system 'clear'

    if match
      puts match.to_s
      search_submenu(match)
    else
      puts "No Match Found For #{number}"
    end
  end

  def search_entries
    print 'Search By Name: '
    name = gets.chomp
    match = @address_book.find_entry(name)
    system 'clear'

    if match
      puts match.to_s
      search_submenu(match)
    else
      puts "No Match Found For #{name}"
    end
  end

  def read_csv
    print 'Enter CSV file to import: '
    file_name = gets.chomp

    if file_name.empty?
      system 'clear'
      puts 'No CSV file read'
      main_menu
    end

    begin
      entry_count = address_book.import_from_csv(file_name).count
      system 'clear'
      puts "#{entry_count} new entries added from #{file_name}"
    rescue
      puts "#{file_name} is not a valid CSV file, please enter the name of a valid CSV file"
      read_csv
    end
  end

  def search_submenu(entry)
    puts "\nd - Delete Entry"
    puts 'e - Edit Entry'
    puts 'm - Main Menu'

    selection = gets.chomp
    case selection
    when 'd'
      system 'clear'
      delete_entry(entry)
      main_menu
    when 'e'
      edit_entry(entry)
      system 'clear'
      main_menu
    when 'm'
      system 'clear'
      main_menu
    else
      system 'clear'
      puts "#{selection} is not a valid input"
      puts entry.to_s
      search_submenu(entry)
    end
  end

  def entry_submenu(entry)
    puts 'n - Next Entry'
    puts 'd - Delete Entry'
    puts 'e - Edit Entry'
    puts 'm - Return to Main Menu'

    selection = gets.chomp

    case selection
    when 'n'
      delete_entry(entry)
    when 'd'
    when 'e'
      edit_entry(entry)
      entry_submenu(entry)
    when 'm'
      system 'clear'
      main_menu
    else
      system 'clear'
      puts "#{selection} is not a valid input"
      entry_submenu(entry)
    end
  end

  def edit_entry(entry)
    updates = {}
    print 'Updated Name: '
    name = gets.chomp
    updates[:name] = name unless name.empty?
    print 'Updated Phone Number: '
    phone_number = gets.chomp
    updates[:phone_number] = phone_number unless phone_number.empty?
    print 'Updated Email: '
    email = gets.chomp
    updates[:email] = email unless email.empty?
    entry.update_attributes(updates)
    system 'clear'
    puts 'Updated Entry:'
    puts Entry.find(entry.id)
  end

  def delete_entry(entry)
    address_book.entries.delete(entry)
    puts "#{entry.name} has been deleted."
  end
end
