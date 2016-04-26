class TodoItem
  include Listable
  attr_reader :description, :due, :priority

  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    case options[:priority]
    when "high", "medium", "low", nil
      @priority = options[:priority]
    else
      raise UdaciListErrors::InvalidPriorityValue
    end
  end
  def details
    arr = self.details_array
    format_description(arr[0]) + arr[1]
  end
  def details_array
    date = format_date(@due)
    date = "No due date" if !date
    [@description, "due: " + date + format_priority(@priority)]
  end
  def self.type
    "todo"
  end
end
