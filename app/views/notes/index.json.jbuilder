json.array!(@notes) do |note|
  json.extract! note, :description
  json.url note_url(note, format: :json)
end
