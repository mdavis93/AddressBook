require_relative '../models/address_book'
require_relative '../models/entry'
require 'record_manager'

RecordManager.connect_to('db/address_book.sqlite')

book = AddressBook.create(name: 'My Address Book')

puts 'Address Book Created Successfully!'
puts 'Entry Created Successfully!'
puts Entry.create(
  address_book_id: book.id,
  name: 'Foo One',
  phone_number: '999-999-9999',
  email: 'foo_one@gmail.com'
)
puts Entry.create(
  address_book_id: book.id,
  name: 'Foo Two',
  phone_number: '111-111-1111',
  email: 'foo_two@gmail.com'
)
puts Entry.create(
  address_book_id: book.id,
  name: 'Foo Three',
  phone_number: '222-222-2222',
  email: 'foo_three@gmail.com'
)