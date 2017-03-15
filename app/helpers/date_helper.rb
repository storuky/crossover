module DateHelper
  def normalize_date date
    Date.parse(date).strftime("%m/%d/%Y")
  end

  def normalize_datetime date
    (DateTime.parse(date) rescue date).strftime("%m/%d/%Y %H:%M")
  end
end