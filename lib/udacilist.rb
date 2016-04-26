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
  def delete(*indices)
    if indices.max > @items.length
      raise UdaciListErrors::IndexExceedsListSize
    end
    new_items = []
    @items.each_with_index do |item, position|
      new_items << item if !indices.include?(position + 1)
    end
    @items = new_items
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
  def filter(type)
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    rows = []
    @items.each_with_index do |item, position|
      rows << ["#{position + 1}", item.class.type] + item.details_array if item.class.type == type
    end
    if rows
      table = Terminal::Table.new :rows => rows
      puts table
    else
      puts "No items of type #{type}"
    end
  end
  def update_priority(item, priority)
    @items[item-1].set_priority(priority)
  end
end
