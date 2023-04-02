# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
file = "notes/bike-data.csv"
CSV.foreach(file, :headers => true) do |row|
    b_current_station = Station.find_by(identifier: row[1])
    b = Bike.new(identifier: row[0])
    b.update(current_station: b_current_station)
    b.save
end

file = "notes/station-data.csv"
CSV.foreach(file, :headers => true) do |row|
  s = Station.new(name: row[1], address: row[6], identifier: row[0])
  s.save
end