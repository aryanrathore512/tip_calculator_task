require 'rails_helper'

RSpec.describe Admin::DashboardController, type: :controller do
  describe 'GET #index' do
    context 'when the request is HTML' do
      it 'returns a successful response' do
        get :index
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("text/html; charset=utf-8")
      end
    end

    context 'when the request is JSON' do
      let!(:calculations) do
        [
          create(:calculation, bill_amount: 100.0, tip_percentage: 10, number_of_people: 2),
          create(:calculation, bill_amount: 200.0, tip_percentage: 15, number_of_people: 3)
        ]
      end

      it 'returns a successful response' do
        get :index, format: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end

      it 'returns the correct JSON structure' do
        get :index, format: :json
        json_response = JSON.parse(response.body)

        expect(json_response['draw']).to eq(0)
        expect(json_response['recordsTotal']).to eq(Calculation.count)
        expect(json_response['recordsFiltered']).to eq(Calculation.count)

        expect(json_response['data']).to be_an(Array)
        expect(json_response['data'].count).to eq(2)

        calculation = json_response['data'].first
        expect(calculation['bill_amount'].to_i).to eq(100.0)
        expect(calculation['tip_percentage'].to_i).to eq(10.0)
        expect(calculation['number_of_people']).to eq(2)
        expect(calculation['tip_amount'].to_i).to eq(20)
        expect(calculation['total_bill'].to_i).to eq(120)
        expect(calculation['per_person_amount'].to_i).to eq(60)
        expect(calculation['created_at']).to eq(calculations.first.created_at.strftime("%Y-%m-%d %H:%M:%S"))
      end
    end
  end
end
