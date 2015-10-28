FactoryGirl.define do
  factory(:user) do
    email('bunker@gmail.com')
    password('password123')
    password_confirmation('password123')
  end
end
