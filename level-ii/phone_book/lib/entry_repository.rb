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
      entry_for(person)
    }
  end

  def find_by_first_and_last_name(first, last)
    (people.find_by(:first_name, first) & people.find_by(:last_name, last)).map {|person|
      entry_for(person)
    }
  end

  def find_by_number(number)
    phone_numbers.find_by(:to_s, number).map {|number|
      people.find_by(:id, number.person_id).map {|person|
        entry_for(person)
      }
    }.flatten
  end

  private

  def entry_for(person)
    numbers = phone_numbers.find_by(:person_id, person.id).map(&:to_s)
    Entry.new(person.first_name, person.last_name, numbers)
  end
end
