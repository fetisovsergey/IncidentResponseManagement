module ApplicationHelper
  def dt(date)
    return "&mdash;".html_safe if date.nil?
    begin
      return l date, format: :short if date.is_a?(Time)
      return l date, format: :default if date.is_a?(Date)
    rescue
      return date
    end
  end

  def to_date(date)
    date.to_time.strftime("%d.%m.%Y")
  end
end
