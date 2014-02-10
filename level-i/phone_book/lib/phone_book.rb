require 'csv'
require_relative 'entry'
require_relative 'entry_repository'

class PhoneBook
  attr_reader :repository

  def initialize(repository=EntryRepository.in('./data'))
    @repository = repository
  end

  def lookup(name)
    lastname, firstname = name.split(', ')
    if firstname
      repository.find_by_first_and_last_name(firstname, lastname)
    else
      repository.find_by_last_name(name)
    end
  end

  def reverse_lookup(number)
    repository.find_by_number(number)
  end
end
