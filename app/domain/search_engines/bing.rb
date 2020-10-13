require 'net/https'

module SearchEngines
  module Bing
    SEARCH_API_URL = 'https://api.cognitive.microsoft.com/bingcustomsearch/v7.0/search'

    def self.execute(query)
      uri = URI(SEARCH_API_URL + "?customConfig=#{ENV['BING_CUSTOM_CONFIG']}&mkt=en-US&q=" + URI.escape(query))

      request = ::Net::HTTP::Get.new(uri)
      request['Ocp-Apim-Subscription-Key'] = ENV['BING_SEARCH_API_KEY']

      response = ::Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
        http.request(request)
      end
      
      return nil unless response.code.to_s == '200'

      result = { items: [] }
      json = JSON.parse(response.body)
      result[:items] = ResultParser.parse_bing_items(json['webPages']['value'])
      result
    rescue => e
      nil
    end
  end
end