FactoryGirl.define do  factory :pgn do
    
  end

  factory :user do
    email 'bunker@gmail.com'
    password 'password123'
    password_confirmation 'password123'
  end

  factory :player do
    name 'Magnus Carlsen'
    rating 2800
  end

  factory :game do
    notation '1. e4 e5 2. Nf3 Nc6'
    players { |p| [p.association(:player)]}
  end
end
