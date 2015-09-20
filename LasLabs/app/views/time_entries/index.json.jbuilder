json.array!(@time_entries) do |time_entry|
  json.extract! time_entry, :id, :start, :end, :rate, :description, :tags, :invoice, :user
  json.url time_entry_url(time_entry, format: :json)
end
