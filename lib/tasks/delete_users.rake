namespace :db do
  task :delete_users => :environment do
    User.destroy_all
  end
end

#echo "alias fuck_the_world='heroku run rake db:nuke_users'" >> ~/.bash_profile