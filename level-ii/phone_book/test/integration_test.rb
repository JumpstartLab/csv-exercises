gem 'minitest', '~> 5.2'
require 'minitest/autorun'
require 'minitest/pride'
require_relative '../lib/phone_book'

class IntegrationTest < Minitest::Test
  def phone_book
    @phone_book ||= PhoneBook.new
  end

  def test_lookup_by_last_name
    entries = phone_book.lookup('Mueller').sort_by {|e| e.first_name}
    assert_equal 2, entries.length
    justina, sharon = entries
    assert_equal "Justina Mueller", justina.name
    assert_equal "Sharon Mueller", sharon.name
    assert_equal ["(433) 346-3946"], justina.numbers
    assert_equal ["(296) 580-0926", "(484) 305-0295", "(836) 069-1792"], sharon.numbers.sort
  end

  def test_lookup_by_last_and_first_name
    entries = phone_book.lookup('Parker, John').sort_by {|e| e.numbers.length }
    assert_equal 2, entries.length
    e1, e2 = entries
    assert_equal ["(174) 189-4353", "(652) 134-7802"], e1.numbers.sort
    assert_equal ["(770) 432-1504", "(901) 482-6846", "(905) 752-5910"], e2.numbers.sort
  end

  def test_reverse_lookup
    entries = phone_book.reverse_lookup('(976) 128-7281')
    assert_equal 1, entries.length
    entry = entries.first
    assert_equal "Augusta Koelpin", entry.name
    numbers = [
      "(146) 836-1999", "(327) 278-1982",
      "(512) 823-6577", "(791) 405-3051",
      "(976) 128-7281"
    ]
    assert_equal numbers, entry.numbers.sort
  end
end

