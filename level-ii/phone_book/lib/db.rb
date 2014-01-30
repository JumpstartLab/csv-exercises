class DB
  def self.read(file, target)
    data = CSV.open(file, headers: true, header_converters: :symbol)
    rows = data.map do |row|
      target.new(row)
    end
    new(rows)
  end

  attr_reader :objects
  def initialize(objects)
    @objects = objects
  end

  def find_by(attribute, value)
    objects.select do |object|
      object.send(attribute) == value
    end
  end
end
