require 'csv'
require_relative 'db'
require_relative 'entry'
require_relative 'person'
require_relative 'phone_number'
require_relative 'entry_repository'

class PhoneBook

  attr_reader :repository
  def initialize(repository=EntryRepository.in('./data'))
    @repository = repository
  end

  def lookup(name)
    repository.find_by_last_name(name)
  end
end
