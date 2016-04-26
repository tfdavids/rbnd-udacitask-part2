class LinkItem
  include Listable
  attr_reader :description, :site_name

  def initialize(url, options={})
    @description = url
    @site_name = options[:site_name]
  end
  def format_name
    @site_name ? @site_name : ""
  end
  def details
    arr = self.details_array
    format_description(arr[0]) + arr[1]
  end
  def details_array
    [@description, "site name: " + format_name]
  end
  def self.type
    "link"
  end
end
