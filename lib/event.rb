class EventItem
  include Listable
  attr_reader :description, :start_date, :end_date

  def initialize(description, options={})
    @description = description
    @start_date = Chronic.parse(options[:start_date]) if options[:start_date]
    @end_date = Chronic.parse(options[:end_date]) if options[:end_date]
  end
  def details
    arr = self.details_array
    format_description(arr[0]) + arr[1]
  end
  def details_array
    date = format_date(@start_date, @end_date)
    date = "N/A" if !date
    [@description, "event dates: " + date]
  end
end
