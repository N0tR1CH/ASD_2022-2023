require_relative 'red_black_tree'
require_relative 'phone_book'

contact_to_initalise_phone_book = PhoneBook::Contact.new(company: 'stupid corp.', address: 'Asd gowno pierdolone 12/2', phone_number: "42133213213")
second_contact = PhoneBook::Contact.new(first_name: 'Damian', last_name: 'Xdowicz' 'stupid corp.', address: 'Asd gowno pierdolone 12/2', phone_number: "42133213213")

my_phone_book = PhoneBook.new(contact_to_initalise_phone_book)
my_phone_book.add(second_contact)

puts my_phone_book.find(contact_to_initalise_phone_book)
puts my_phone_book.find(second_contact)
