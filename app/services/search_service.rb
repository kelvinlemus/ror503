class SearchService < BaseService
  VALID_ENGINES = ['google', 'bing']

  def initialize(params)
    @engines = params[:engine].to_s.downcase.split(',').select { |obj| VALID_ENGINES.include?(obj) }
    @query = params[:query]
  end

  def process
    @result = {
      google_results: nil,
      bing_results: nil
    }
    return @result if @query.blank?

    @result[:google_results] = SearchEngines::Google.execute(@query) if is_engine_included?('google')
    @result[:bing_results] = SearchEngines::Bing.execute(@query) if is_engine_included?('bing')

    @result
  end

private
  def is_engine_included?(engine_name)
    @engines.include?(engine_name)
  end
end