class CalculationsController < ApplicationController
  def create
    calculation = Calculation.new(calculation_params)

    if calculation.valid?
      calculation.save
      render json: calculation_response(calculation), status: :ok
    else
      render json: { errors: calculation.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def calculation_params
    permitted_params = params.require(:calculation).permit(:bill_amount, :tip_percentage, :number_of_people)

    tip_calculations = calculation_of_tip(permitted_params)
    permitted_params[:tip_amount] = tip_calculations[:tip_amount]
    permitted_params[:total_bill] = tip_calculations[:total_bill]
    permitted_params[:per_person_amount] = tip_calculations[:per_person_amount]

    permitted_params
  end

  def calculation_of_tip(params)
    @bill_amount = params[:bill_amount].to_i
    @tip_percentage = params[:tip_percentage].to_i
    @number_of_people = params[:number_of_people].to_i

    tip_amount = ((@bill_amount * @tip_percentage) / 100)
    total_bill = (@bill_amount + tip_amount)
    per_person_amount = @number_of_people > 0 ? total_bill / @number_of_people : 0
    { tip_amount: tip_amount, total_bill: total_bill, per_person_amount: per_person_amount }
  end

  def calculation_response(calculation)
    {
      tip_amount: calculation.tip_amount,
      total_amount: calculation.per_person_amount
    }
  end
end