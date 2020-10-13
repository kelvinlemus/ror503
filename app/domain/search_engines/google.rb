require 'google/apis/customsearch_v1'

module SearchEngines
  module Google
    def self.execute(query, start: nil, **)
      options = {
        q: query,
        cx: ENV['GOOGLE_CUSTOM_SEARCH_CX']
      }
      options[:start] = start if start.present?

      search_client = ::Google::Apis::CustomsearchV1::CustomSearchAPIService.new
      search_client.key = ENV['GOOGLE_CUSTOM_SEARCH_API_KEY']
      response = search_client.list_cses(options)
      
      result = { items: [] }
      result[:items] = ResultParser.parse_google_items(response.items) if response.items
      result
    rescue => e
      nil
    end
  end
end