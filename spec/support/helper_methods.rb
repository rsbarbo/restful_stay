def login(user, password)
  visit login_path
  fill_in "Email", with: user.email_address
  fill_in "Password", with: password
  click_on "login-button"
end

def login_as_host
  user = User.find_by(first_name: "Host")
  login(user, 'host')
end

def login_as_traveler
  user = User.find_by(first_name: "Traveler")
  login(user, 'traveler')
end

def login_as_admin
  user = User.find_by(first_name: "Admin")
  login(user, 'admin')
end

def make_listing_for_booking
  Listing.make({name: "Cool Room",
                description: "This is a cool place",
                image_url: Faker::Avatar.image,
                price_per_night: 65.50,
                city_id: City.find_by(name: "Denver").id,
                start_date: Day.all[10].id,
                end_date: Day.all[20].id },
                User.find_by(first_name: "denverhost").id).save
  return Listing.find_by(name: "Cool Room")
end
