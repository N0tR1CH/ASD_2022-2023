# frozen_string_literal: true

require 'byebug'
require_relative 'red_black_tree'

class PhoneBook
  attr_reader :tree

  class Contact
    attr_reader :first_name, :last_name, :address, :phone_number, :company

    def initialize(address:, phone_number:, first_name: nil, last_name: nil, company: nil)
      if first_name && last_name && company
        raise ARgumentError, 'Cannot provide both first_name and last_name and company'
      elsif !(first_name && last_name) && !company
        raise ArgumentError, 'Must provide either first_name and last_name or company'
      end

      @first_name = first_name
      @last_name = last_name
      @company = company
      @address = address
      @phone_number = [phone_number]
    end

    def to_s
      puts "#{@first_name} #{@last_name} #{address} #{phone_number}" if @company.nil?
      puts "#{@company} #{address} #{phone_number}" if @company
    end
  end

  def initialize(contact)
    @tree = if contact.company.nil?
              RedBlackTree.new("#{contact.first_name} #{contact.last_name} #{contact.address}", contact)
            else
              RedBlackTree.new("#{contact.company} #{contact.address}", contact)
            end
  end

  def add(contact)
    if contact.company.nil?
      @tree.insert("#{contact.first_name} #{contact.last_name} #{contact.address}", contact)
    else
      @tree.insert("#{contact.company} #{contact.address}", contact)
    end
  end

  def remove(contact)
    if contact.company.nil?
      @tree.delete("#{contact.first_name} #{contact.last_name} #{contact.address}")
    else
      @tree.delete("#{contact.company} #{contact.address}")
    end
  end

  def find(contact)
    if contact.company.nil?
      @tree.search("#{contact.first_name} #{contact.last_name} #{contact.address}")
    else
      @tree.search("#{contact.company} #{contact.address}")
    end
  end
end
