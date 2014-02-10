class EntryRepository
  def self.in(dir)
    file = File.join(dir, 'people.csv')
    data = CSV.open(file, headers: true, header_converters: :symbol)
    rows = data.map do |row|
      Entry.new(row)
    end
    new(rows)
  end

  attr_reader :entries

  def initialize(entries)
    @entries = entries
  end

  def find_by_last_name(name)
    entries.select {|entry| entry.last_name == name}
  end

  def find_by_first_and_last_name(first, last)
    entries.select {|entry|
      entry.first_name == first
    }.select {|entry|
      entry.last_name == last
    }
  end

  def find_by_number(number)
    entries.select {|entry| entry.phone_number == number}
  end

end
