json.data do
  if @google_results
    json.google_results @google_results[:items] do |item|
      json.title item.title
      json.engine item.engine
      json.url item.url
    end
  else
    json.google_results []
  end

  if @bing_results
    json.bing_results @bing_results[:items] do |item|
      json.title item.title
      json.engine item.engine
      json.url item.url
    end
  else
    json.bing_results []
  end
end