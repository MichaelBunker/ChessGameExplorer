players = [
  [ "Bunker", 1500 ],
  [ "Josue", 1111 ],
  [ "Magnus Carlsen", 2955 ],
  [ "Fabiano Caruana", 2778 ]
]

players.each do |name, rating|
  Player.create( name: name, rating: rating )
end

user = User.new
user.email = 'bunker@gmail.com'
user.password = 'password123'
user.password_confirmation = 'password123'
user.save!
