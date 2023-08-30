class Person < ApplicationRecord
  validates :name, :date_of_birth, presence: true
  validate :date_of_birth, :valid_date_of_birth

  def date_of_birth=(date)
    if date.is_a?(Hash)
      @date_field_validity = {} if @date_field_validity.nil?

      begin
        raise ArgumentError if date.values.any?(&:nil?)
        Date.new(date[1], date[2], date[3])
        @date_field_validity[:date_of_birth] = true
      rescue ArgumentError
        @date_field_validity[:date_of_birth] = false
        date = nil
      end
    end

    super(date)
  end

  def valid_date_of_birth
    if @date_field_validity.present? && @date_field_validity[:date_of_birth] == false
      errors.add(:date_of_birth, "must be a valid date")
    end
  end
end
