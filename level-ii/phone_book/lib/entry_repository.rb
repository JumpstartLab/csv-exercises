class EntryRepository
  def self.in(dir)
    people = DB.read(File.join(dir, 'people.csv'), Person)
    phone_numbers = DB.read(File.join(dir, 'phone_numbers.csv'), PhoneNumber)
    new(people, phone_numbers)
  end

  attr_reader :people, :phone_numbers
  def initialize(people, phone_numbers)
    @people = people
    @phone_numbers = phone_numbers
  end

  def find_by_last_name(name)
    people.find_by(:last_name, name).map {|person|
      numbers = phone_numbers.find_by(:person_id, person.id).map(&:to_s)
      Entry.new(person.first_name, person.last_name, numbers)
    }
  end
end
