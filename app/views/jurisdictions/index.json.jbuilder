json.array!(@jurisdictions) do |jurisdiction|
  json.extract! jurisdiction, :id
  json.url jurisdiction_url(jurisdiction, format: :json)
end
