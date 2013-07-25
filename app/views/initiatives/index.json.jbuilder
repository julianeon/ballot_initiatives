json.array!(@initiatives) do |initiative|
  json.extract! initiative, :election_date, :prop_letter, :title, :description, :pass_fail, :yes_count, :no_count, :percent_required, :measure_type, :initiator, :scan_url
  json.url initiative_url(initiative, format: :json)
end