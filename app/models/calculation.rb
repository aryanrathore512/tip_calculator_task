class Calculation < ApplicationRecord
  validates :number_of_people, numericality: { greater_than: 0, message: "must be greater than 0" }
  validates :bill_amount, numericality: { greater_than: 0, message: "must be greater than 0" }
  validates :tip_percentage, numericality: { greater_than: 0, message: "must be greater than 0" }
end
