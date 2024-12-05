puts "Cleaning database..."
Article.destroy_all
Event.destroy_all
User.destroy_all

puts "Creating users..."
10.times do
  user = User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    year_of_arrival: Date.new(Faker::Date.between(from: '2010-01-01', to: '2023-01-01').year),
    password: "password",
    password_confirmation: "password"
  )

  file = URI.open("https://picsum.photos/200")
  user.profile_pic.attach(io: file, filename: "profile_pic.jpg", content_type: "image/jpeg")

  puts "Created user #{user.first_name} #{user.last_name}"
end

puts "Creating articles..."
# On crée des articles associés aux utilisateurs
User.all.each do |user|
  5.times do
    # Créez un article avec un titre, un contenu et une image aléatoire
    article = Article.create!(
      title: Faker::Book.title,
      description: Faker::Lorem.paragraph(sentence_count: 5),
      user: user,
    )

    # Attache une image aléatoire à l'article
    url = "https://picsum.photos/800/600" # Utilisez une image aléatoire de Lorem Picsum
    file = URI.open(url)
    article.images.attach(io: file, filename: "article_#{article.id}.jpg", content_type: "image/jpeg")

    puts "Created article '#{article.title}' by #{user.first_name} #{user.last_name} with an image"
  end
end

puts "Creating events with images..."

10.times do
  begin
    event = Event.create!(
      title: Faker::Lorem.sentence(word_count: 3),
      location: Faker::Address.full_address,
      event_date: Faker::Date.forward(days: 30),
      number_of_people: rand(10..100),
      user: User.all.sample
    )

    file = URI.open("https://picsum.photos/800/600")
    event.images.attach(io: file, filename: "event_#{event.id}.jpg", content_type: "image/jpeg")

    puts "Created event '#{event.title}' with an image at #{event.location}"
  rescue OpenURI::HTTPError => e
    puts "Failed to attach image for event '#{event.title}': #{e.message}"
  end
end

puts "Finished creating events!"

puts "Finished!"
