# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


start_time = Time.current - 1.week

while start_time < Time.current
	SensorReading.create!(
		time_at: start_time,
		device_id: "device_#{rand(1..5)}",
		temperature: rand(15.0..30.0).round(2),
		humidity: rand(30.0..70.0).round(2),
		voltage: rand(3.0..4.2).round(2)
	)

	# Praticamente, como os dados são raw, eu não me importo com o período enviado
	start_time += rand(1..60).minutes
end