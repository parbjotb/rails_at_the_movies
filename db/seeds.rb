# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require "csv"
# saying require csv gives us access to csv.parse() and other methods

# now we wipe database then load it with info
Movie.delete_all
ProductionCompany.delete_all

filename = Rails.root.join("db/top_movies.csv")

puts "Loading movies from the CSV file: #{filename}"

csv_data = File.read(filename)
# this is the line that reads in the csv file
movies = CSV.parse(csv_data, headers: true, encoding: "utf-8")

# this prints out the title for each movie m
# we accesss the original_title column with this notation
movies.each do |m|
  # puts m["original_title"]
  # this either creates a new production company, or if it exists, it finds it
  # so one way or another, there will be an object we can use for the association between prod and movie
  production_company = ProductionCompany.find_or_create_by(name: m["production_company"])

  # if production company exists and is valid then do this
  if production_company && production_company.valid?
    # create movie here after company is not null
    # this lets us create movies off the production company, thus wiring up the foreign key relation
    movie = production_company.movies.create(
      title:        m["original_title"],
      year:         m["year"],
      duration:     m["duration"],
      description:  m["description"],
      average_vote: m["avg_vote"]
    )
    # print the error unless the movie created is valid
    puts "Invalid movie #{m['original_title']}" unless movie&.valid?
  else
    puts "Invalid production company: #{m['production_company']} for movie: #{m['original_title']}"
  end
end

puts "Created #{ProductionCompany.count} Production Companies"
puts "Created #{Movie.count} movies."
