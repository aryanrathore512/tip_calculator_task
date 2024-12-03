class Admin::DashboardController < ApplicationController
  def index
    @calculations = Calculation.all
    respond_to do |format|
      format.html
      format.json { render json: {
          draw: params[:draw].to_i,
          recordsTotal: @calculations.count,
          recordsFiltered: @calculations.count,
          data: @calculations.map { |calculation|
            {
              bill_amount: calculation.bill_amount,
              tip_percentage: calculation.tip_percentage,
              number_of_people: calculation.number_of_people,
              tip_amount: calculation.tip_amount,
              total_bill: calculation.total_bill,
              per_person_amount: calculation.per_person_amount,
              created_at: calculation.created_at.strftime("%Y-%m-%d %H:%M:%S")
            }
          }
        }
      }
    end
  end
end
