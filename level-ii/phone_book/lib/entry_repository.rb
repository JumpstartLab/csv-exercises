class EntryRepository
  def self.in(dir)
    people = DB.read(File.join(dir, 'people.csv'), Person)
    numbers = DB.read(File.join(dir, 'phone_numbers.csv'), PhoneNumber)
    new(people, numbers)
  end

  attr_reader :person_db, :number_db

  def initialize(person_db, number_db)
    @person_db = person_db
    @number_db = number_db
  end

  def find_by_last_name(name)
    people = person_db.find_by(:last_name, name)
    people.map do |person|
      numbers = number_db.find_by(:person_id, person.id)
      Entry.new(person.first_name, person.last_name, numbers.map(&:to_s))
    end
  end

  def find_by_first_and_last_name(first, last)
    people = person_db.find_by(:first_name, first) & person_db.find_by(:last_name, last)
    people.map do |person|
      numbers = number_db.find_by(:person_id, person.id)
      Entry.new(person.first_name, person.last_name, numbers.map(&:to_s))
    end
  end

  def find_by_number(number)
    id = number_db.find_by(:to_s, number).first.person_id
    person = person_db.find_by(:id, id).first
    numbers = number_db.find_by(:person_id, id)
    [Entry.new(person.first_name, person.last_name, numbers.map(&:to_s))]
  end
end
