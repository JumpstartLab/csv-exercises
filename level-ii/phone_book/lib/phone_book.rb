require 'csv'
require_relative 'db'
require_relative 'person'
require_relative 'phone_number'
require_relative 'entry'
require_relative 'entry_repository'

class PhoneBook
  attr_reader :repository

  def initialize(repository=EntryRepository.in('./data'))
    @repository = repository
  end

  def lookup(name)
    last_name, first_name = name.split(', ')

    if first_name
      repository.find_by_first_and_last_name(first_name, last_name)
    else
      repository.find_by_last_name(last_name)
    end
  end

  def reverse_lookup(number)
    repository.find_by_number(number)
  end
end
