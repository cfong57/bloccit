require 'faker'

# Create 25 topics
topics = []
25.times do
  topics << Topic.create(
    name: Faker::Song.lyric, 
    description: Faker::Song.paragraph)
end

#Create some users
(15 + rand(4..10)).times do
  password = Faker::Lorem.characters(10)
  u = User.new(
    name: Faker::Name.name, 
    email: Faker::Internet.email, 
    password: password, 
    password_confirmation: password)
  u.skip_confirmation!
  u.save
  
  #Create some posts
  (15 + rand(5..12)).times do
    topic = topics.first # getting the first topic here
    p = u.posts.create(
      topic: topic,
      title: Faker::Song.lyric, 
      body: Faker::Song.paragraph)
    # set the created_at to a time within the past year
    p.update_attribute(:created_at, Time.now - rand(600..31536000))
    p.update_rank
    topics.rotate! # add this line to move the first topic to the last, so that posts get assigned to different topics.
    
    #Create some comments
    3.times do
      c = u.comments.create(body: Faker::Song.paragraph, post: p)
      c.update_attribute(:created_at, Time.now - rand(600..31536000))
    end
  end
end

u = User.new(
  name: 'Admin User',
  email: 'admin@example.com', 
  password: 'helloworld', 
  password_confirmation: 'helloworld')
u.skip_confirmation!
u.save
u.update_attribute(:role, 'admin')

u = User.new(
  name: 'Moderator User',
  email: 'moderator@example.com', 
  password: 'helloworld', 
  password_confirmation: 'helloworld')
u.skip_confirmation!
u.save
u.update_attribute(:role, 'moderator')

u = User.new(
  name: 'Member User',
  email: 'member@example.com', 
  password: 'helloworld', 
  password_confirmation: 'helloworld')
u.skip_confirmation!
u.save

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Post.count} posts created"
puts "#{Comment.count} comments created"