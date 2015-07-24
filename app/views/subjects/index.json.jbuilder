json.array!(@subjects) do |subject|
  json.extract! subject, :id, :name, :study_semester
  json.url subject_url(subject, format: :json)
end
