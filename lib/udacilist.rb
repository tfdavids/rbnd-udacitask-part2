class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title] || "Untitled List"
    @items = []
  end
  def add(type, description, options={})
    type = type.downcase
    case type
    when "todo"
      @items.push TodoItem.new(description, options)
    when "event"
      @items.push EventItem.new(description, options)
    when "link"
      @items.push LinkItem.new(description, options)
    else
      raise UdaciListErrors::InvalidItemType
    end
  end
  def delete(index)
    if index > @items.length
      raise UdaciListErrors::IndexExceedsListSize
    end
    @items.delete_at(index - 1)
  end
  def all
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end
  def table
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    rows = []
    @items.each_with_index do |item, position|
      rows << ["#{position + 1}", item.class.type] + item.details_array
    end
    table = Terminal::Table.new :rows => rows
    puts table
  end
end
