require 'red_black_tree'

class PhoneBook
  attr_reader :tree

  class Contact
    attr_reader %i[first_name last_name address phone_number company]

    def initialize(first_name: nil, last_name: nil, company: nil, address:, phone_number:)
      if (first_name && last_name && company)
        raise ARgumentError, "Cannot provide both first_name and last_name and company"
      elsif !(first_name && last_name) && !company
        raise ArgumentError, "Must provide either first_name and last_name or company"

      @first_name = first_name
      @last_name = last_name
      @company = company
      @address = address
      @phone_number = [phone_number]
    end
  end

  def initialize
    @tree = RedBlackTree.new
  end

  def add(contact)
    if company.nil?
      @tree.insert("#{contact.first_name} #{contact.second_name} #{contact.address}", contact)
    else
      @tree.insert("#{contact.company} #{contact.address}", contact)
    end
  end

  def remove(contact)
    if company.nil?
      @tree.delete("#{contact.first_name} #{contact.second_name} #{contact.address}")
    else
      @tree.delete("#{contact.company} #{contact.address}")
    end
  end

  def find(contact)
    if company.nil?
      @tree.find("#{contact.first_name} #{contact.second_name} #{contact.address}")
    else
      @tree.find("#{contact.company} #{contact.address}")
    end
  end

end
