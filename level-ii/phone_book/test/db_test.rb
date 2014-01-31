gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require 'csv'
require_relative '../lib/db'

class DBTest < Minitest::Test
  class Thing
    attr_reader :id, :name
    def initialize(data)
      @id = data[:id]
      @name = data[:name]
    end
  end

  def filename
    @filename ||= File.absolute_path("../fixtures/things.csv", __FILE__)
  end

  def db
    DB.read(filename, Thing)
  end

  def test_find_by_name
    things = db.find_by(:name, "tire")
    assert_equal 2, things.size
    assert_equal ["2", "3"], things.map(&:id)
  end
end
