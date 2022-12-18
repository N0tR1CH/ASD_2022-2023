# frozen_string_literal: true

require_relative 'avl_tree'

# Klasa reprezentująca książke telefoniczną
class PhoneBook
  attr_reader :tree

  # Podklasa klasy PhoneBook, reprezentuje kontakt książki telefonicznej
  class Contact
    attr_accessor :first_name, :last_name, :address, :phone_number, :company

    def initialize(address:, phone_number:, first_name: nil, last_name: nil, company: nil)
      if first_name && last_name && company
        raise ARgumentError,
              'Cannot provide both first_name and last_name and company'
      elsif !(first_name && last_name) && !company
        raise ArgumentError,
              'Must provide either first_name and last_name or company'
      end

      @first_name = first_name
      @last_name = last_name
      @company = company
      @address = address
      @phone_number = [phone_number]
    end

    def to_s
      case @company
      when nil
        puts "#{@first_name} #{@last_name} #{@address} #{@phone_number}"
      when true
        puts "#{@company} #{@address} #{@phone_number}" if @company
      end
    end
  end

  def initialize
    @tree = AVLTree.new
  end

  def add(contact)
    if contact.company.nil?
      @tree.insert("#{contact.first_name} #{contact.last_name} #{contact.address}", contact)
    else
      @tree.insert("#{contact.company} #{contact.address}", contact)
    end
  end

  def remove(key)
    @tree.delete(key)
  end

  def find(key)
    @tree.search(key).value
  end

  def add_number_to_existing_contact(key, number)
    @tree.search(key).value.phone_number << number
  end

  def to_file(file_name)
    file = File.open(file_name, 'w')
    file.puts(@tree.inorder_traversal)
  end

  def companies_from_file(file_name)
    IO.foreach(file_name) do |line|
      words = line.split('|')
      add(Contact.new(company: words[0], address: words[1], phone_number: words[2]))
    end
  end

  def people_from_file(file_name)
    IO.foreach(file_name) do |line|
      words = line.split('|')
      add(Contact.new(first_name: words[0], last_name: words[1], address: words[2], phone_number: words[3]))
    end
  end
end
