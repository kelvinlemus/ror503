module SearchEngines
  module ResultParser
    Item = Struct.new(:title, :engine, :url, :description)

    def self.parse_google_items(items=[])
      items.map do |item|
        Item.new(item.title, 'google', item.link, '')
      end
    end

    def self.parse_bing_items(items=[])
      items.map do |item|
        Item.new(item['name'], 'bing', item['url'], item['snippet'])
      end
    end
  end
end