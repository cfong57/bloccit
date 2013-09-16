namespace :db do
  task :init_admin
    users = User.all
    beater = nil
    users.each do |user|
      beater = user if user.name =~ /Kirito/
    end
    if(!(beater.nil?))
      u = User.new(
      name: "Kirito",
      email: "kirito@sao.com", 
      password: "hayaku", 
      password_confirmation: "hayaku")
      u.skip_confirmation!
      u.save
      u.update_attribute(:role, 'admin')
    end
  end
end