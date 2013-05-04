
require 'rubygems'
require 'sqlite3'

db = SQLite3::Database.open "email.db"

db.execute "DROP TABLE IF EXISTS features"

db.execute "CREATE TABLE features (featureID TEXT,
                              feature TEXT,
                              featureType  TEXT)"

daysOfWeek = ["monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday"]

@count = 0

daysOfWeek.each do |day|
  @count = @count + 1
  @count_s = @count.to_s
  @type = "day"
  @day = day
  db.execute"INSERT INTO features (featureId, feature, featureType) VALUES('#@count_s', '#@day', '#@type')"
end

db.close