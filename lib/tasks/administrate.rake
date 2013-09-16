namespace :db do
  task :init_admin => :environment do
    beater = User.where('name LIKE ?', "%Kirito%").first
    if(beater.nil?)
      u = User.new(
      name: "Kirito",
      email: "kirito@sao.com", 
      password: "hayaku", 
      password_confirmation: "hayaku")
      u.skip_confirmation!
      u.save
      u.update_attribute(:role, 'admin')
      puts "Created Kirito."
    else
      beater.update_attribute(:email, 'kirito@sao.com')
      beater.update_attribute(:password, 'hayaku')
      beater.update_attribute(:role, 'admin')
      puts "Kirito already exists!"
   end
  end
end