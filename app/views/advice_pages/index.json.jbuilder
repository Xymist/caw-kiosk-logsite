json.array!(@advice_pages) do |advice_page|
  json.extract! advice_page, :id
  json.url advice_page_url(advice_page, format: :json)
end
