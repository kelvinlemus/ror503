require 'rails_helper'

describe 'API/V1 - Search' do
  it 'should fetch google search results' do

    allow(SearchEngines::Google).to receive(:execute).and_return({items: [
      SearchEngines::ResultParser::Item.new('title', 'engine', 'url', 'description'),
      SearchEngines::ResultParser::Item.new('title', 'engine', 'url', 'description'),
    ]})

    headers = { "ACCEPT" => "application/json" }
    get '/api/v1/search', params: { engine: 'google', query: 'js' }, headers: headers
    json = JSON.parse(response.body)
    
    expect(json['data']['bing_results']).to eq []
    expect(json['data']['google_results'].size).to eq 2
    expect(json['data']['google_results'][0]).to eq({ title: 'title', engine: 'engine', url: 'url' }.as_json)
  end
end