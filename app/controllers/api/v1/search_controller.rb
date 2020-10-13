module Api
  module V1
    class SearchController < ApplicationController
      def index
        result = SearchService.perform(params)

        @google_results = result[:google_results]
        @bing_results = result[:bing_results]
      end
    end
  end
end