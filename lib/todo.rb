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
    date = format_date(@due)
    date = "No due date" if !date
    format_description(@description) + "due: " +
    date +
    format_priority(@priority)
  end
end
