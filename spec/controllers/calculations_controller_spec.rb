require 'rails_helper'

RSpec.describe CalculationsController, type: :controller do
  describe "POST #create" do
    context 'when the request is valid' do
      let(:valid_params) do
        {
          calculation: {
            bill_amount: 100,
            tip_percentage: 15,
            number_of_people: 4
          }
        }
      end

      it 'creates a new calculation and returns the correct JSON response' do
        post :create, params: valid_params
        expect(response.status).to eq(200)
      end
    end

    context "when the request is invalid" do
      it "returns an error message when missing a parameter" do
        invalid_params = {
          calculation: {
            bill_amount: 100.0,
            tip_percentage: 10.0
          }
        }

        post :create, params: invalid_params
        json_response = JSON.parse(response.body)
        expect(json_response["total_amount"].to_i).to eq(0)
      end

      it "returns an error message for invalid bill amount" do
        invalid_params = {
          calculation: {
            bill_amount: -100.0,
            tip_percentage: 10.0,
            number_of_people: 2
          }
        }

        post :create, params: invalid_params

        expect(response.status).to eq(422)
      end
    end
  end
end
