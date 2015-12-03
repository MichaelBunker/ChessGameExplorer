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

games = [
  ["1. e4 d5 2. exd5 Qxd5 3. Nc3 Qa5"]
  ["1. d4 d5 2. c4 dxc4 3. Nf3 e6 4. Nc3 Nc6 5. e3"]
  ["1. e4 d5 2. e5 e6 3. Nc3"]
  ["1. e4 e5 2. Nf3 Nc6 3. Bb5"]
  ["1. e4 e5 2. Nf3 Nc6 3. Bb5 d6 4. Bxc6+"]
  ["1. e4 e5 2. Nf3 Nc6 3. Bb5 Bd6"]
]

games.each do |notation|
  Game.create(notation: notation)
