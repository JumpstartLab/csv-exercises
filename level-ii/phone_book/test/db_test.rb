gem 'minitest', '~> 5.0'
require 'csv'
require 'minitest/autorun'
require 'minitest/pride'
require './lib/db'

class DBTest < Minitest::Test
  class Thing
    attr_reader :id, :name
    def initialize(data)
      @id = data[:id].to_i
      @name = data[:name]
    end
  end

  def filename
    @filename ||= File.absolute_path("../fixtures/things.csv", __FILE__)
  end

  def db
    @db ||= DB.read(filename, Thing)
  end

  def test_find_by_id
    things = db.find_by(:id, 1)
    assert_equal 1, things.size
    thing = things.first
    assert_equal Thing, thing.class
    assert_equal "popsicle", thing.name
  end

  def test_find_by_name
    things = db.find_by(:name, "tire")
    assert_equal 2, things.size
    assert_equal [Thing], things.map(&:class).uniq
    assert_equal [2, 3], things.map(&:id)
  end
end
