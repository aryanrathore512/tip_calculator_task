require 'rails_helper'

RSpec.describe Calculation, type: :model do
  subject { Calculation.new(number_of_people: 10, bill_amount: 100, tip_percentage: 15) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end

    it 'is not valid without a number_of_people' do
      subject.number_of_people = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:number_of_people]).to include("must be greater than 0")
    end

    it 'is not valid with number_of_people less than or equal to 0' do
      subject.number_of_people = 0
      expect(subject).to_not be_valid
      expect(subject.errors[:number_of_people]).to include("must be greater than 0")
    end

    it 'is not valid without a bill_amount' do
      subject.bill_amount = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:bill_amount]).to include("must be greater than 0")
    end

    it 'is not valid with bill_amount less than or equal to 0' do
      subject.bill_amount = 0
      expect(subject).to_not be_valid
      expect(subject.errors[:bill_amount]).to include("must be greater than 0")
    end

    it 'is not valid without a tip_percentage' do
      subject.tip_percentage = nil
      expect(subject).to_not be_valid
      expect(subject.errors[:tip_percentage]).to include("must be greater than 0")
    end

    it 'is not valid with tip_percentage less than or equal to 0' do
      subject.tip_percentage = 0
      expect(subject).to_not be_valid
      expect(subject.errors[:tip_percentage]).to include("must be greater than 0")
    end
  end
end
