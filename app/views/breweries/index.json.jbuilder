json.array!(@active_breweries) do |brewery|
  json.extract! brewery, :name, :year
end

json.array!(@retired_breweries) do |brewery|
  json.extract! brewery, :name, :year
end
