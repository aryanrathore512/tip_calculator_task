class CalculationsDatatable < AjaxDatatablesRails::ActiveRecord
  def view_columns
    @view_columns ||= {
      bill_amount: { source: "Calculation.bill_amount" },
      tip_percentage: { source: "Calculation.tip_percentage" },
      number_of_people: { source: "Calculation.number_of_people" },
      tip_amount: { source: "Calculation.tip_amount" },
      total_bill: { source: "Calculation.total_bill" },
      per_person_amount: { source: "Calculation.per_person_amount" },
      created_at: { source: "Calculation.created_at" },
    }
  end

  def data
    records.map do |record|
      {
        bill_amount: record.bill_amount,
        tip_percentage: record.tip_percentage,
        number_of_people: record.number_of_people,
        tip_amount: record.tip_amount,
        total_bill: record.total_bill,
        per_person_amount: record.per_person_amount,
        created_at: record.created_at,
      }
    end
  end

  def get_raw_records
    Calculation.all
  end

  def as_json(*)
    {
      draw: params[:draw].to_i,
      recordsTotal: total_count,
      recordsFiltered: total_count,
      data: data
    }
  end

  private

  def total_count
    Calculation.count
  end
end
