require "test_helper"

class PersonTest < ActiveSupport::TestCase
  def build_person(attributes = {})
    default_attributes = { name: "John" }
    Person.new(default_attributes.merge(attributes))
  end

  test "valid multi-parameter form input" do
    form_input = { 1 => 2023, 2 => 8, 3 => 30 }
    person = build_person(date_of_birth: form_input)
    assert person.valid?
    assert_equal Date.parse("30/08/2023"), person.date_of_birth
  end

  test "invalid multi-parameter form input" do
    form_input = { 1 => 2023, 2 => 8, 3 => 40 }
    person = build_person(date_of_birth: form_input)
    assert person.invalid?
    assert_nil person.date_of_birth
    assert_equal ["Date of birth can't be blank", "Date of birth must be a valid date"], person.errors.to_a
  end

  test "partial multi-parameter form input" do
    form_input = { 1 => 2023, 2 => nil, 3 => 30 }
    person = build_person(date_of_birth: form_input)
    assert person.invalid?
    assert_nil person.date_of_birth
    assert_equal ["Date of birth can't be blank", "Date of birth must be a valid date"], person.errors.to_a
  end

  test "blank date of birth" do
    person = build_person(date_of_birth: nil)
    assert person.invalid?
    assert_nil person.date_of_birth
    assert_equal ["Date of birth can't be blank"], person.errors.to_a
  end
end
