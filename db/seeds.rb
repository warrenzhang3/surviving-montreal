require 'open-uri'

puts "Cleaning database..."
Article.destroy_all
Event.destroy_all
User.destroy_all

puts "Creating users..."
10.times do |i|
  first_name = ["Carlos", "Maria", "Jose", "Ana", "Luis", "Sofia", "Pedro", "Laura", "Jorge", "Lucia"].sample
  last_name = ["Gomez", "Martinez", "Lopez", "Hernandez", "Diaz", "Perez", "Sanchez", "Ramirez", "Cruz", "Morales"].sample

  user = User.create!(
    first_name: first_name,
    last_name: last_name,
    email: "user#{i+1}@example.com",
    year_of_arrival: rand(2010..2023),
    password: "password",
    password_confirmation: "password"
  )

  file = URI.open("https://picsum.photos/200")
  user.profile_pic.attach(io: file, filename: "profile_pic.jpg", content_type: "image/jpeg")

  puts "Created user #{user.first_name} #{user.last_name}"
end

puts "Creating articles..."
topics = [
  {
    title: "Choosing the Right Winter Boots",
    description: "Choosing the right winter boots can make a huge difference in staying warm and comfortable during the harsh Montreal winters. Look for boots that offer insulation, waterproof materials, and good traction to prevent slips on icy surfaces. Consider the height of the boot to ensure it covers your ankles and lower legs for added warmth.

Last winter, I found myself slipping all over the place with my old boots. They weren’t waterproof either, so my feet were always cold and wet. Then I learned about the importance of proper winter boots. After some research, I bought a pair with good insulation and waterproofing. It made all the difference. I could walk confidently on icy sidewalks and my feet stayed warm and dry all day."
  },
  {
    title: "Finding the Perfect Winter Coat",
    description: "A good winter coat is essential for braving the cold in Montreal. When selecting a coat, consider factors such as insulation, waterproofing, and wind resistance. Down coats provide excellent warmth, while synthetic insulation is a great alternative for those who prefer not to use animal products. Make sure the coat fits well and allows for layering.

I remember my first winter here, I had a thin jacket that wasn’t nearly warm enough. I would layer up with sweaters underneath, but it still wasn’t enough. Eventually, I invested in a proper winter coat with down insulation and a waterproof exterior. The difference was incredible. I could actually enjoy being outside in the cold without shivering."
  },
  {
    title: "Selecting Warm Gloves and Hats",
    description: "Keeping your extremities warm is crucial in winter. Invest in high-quality gloves and hats that offer insulation and protection against the cold. Look for gloves with touchscreen compatibility if you need to use your smartphone outside. A good hat should cover your ears and be made of a material like wool or fleece for optimal warmth.

I used to underestimate the importance of good gloves and hats. One particularly cold day, my hands felt like they were freezing, and I couldn’t use my phone without taking my gloves off. That’s when I realized I needed better gear. I bought gloves that were insulated and touchscreen-compatible, and a wool hat that covered my ears. It made a huge difference in comfort and usability."
  },
  {
    title: "Winter Clothing Essentials",
    description: "Layering is key to staying warm in winter. Start with a moisture-wicking base layer, add an insulating middle layer, and finish with a waterproof and windproof outer layer. Choose materials like merino wool and synthetic fabrics for their insulating properties and ability to keep you dry.

During my first winter, I didn’t know how to dress properly for the cold. I would just wear a thick sweater under my coat, but I was still cold. After learning about layering, I started wearing a thermal base layer, a fleece jacket, and a waterproof coat. This combination kept me warm and dry even in the harshest weather."
  },
  {
    title: "Using a Dishwasher",
    description: "A dishwasher can save you a lot of time and effort in the kitchen. To use a dishwasher effectively, load it properly with dishes facing inward and avoid overcrowding. Use the appropriate detergent and select the right cycle for the level of soiling. Regularly clean the dishwasher filter to maintain its efficiency.

When I first encountered a dishwasher, I was clueless about how to use it properly. My roommates advised me to just throw everything in and let it run. After a few cycles, I noticed the dishes weren’t getting clean. I researched a bit and found out I needed to load it correctly and clean the filter regularly. After that, my dishes came out sparkling clean."
  },
  {
    title: "How to Operate a Dryer",
    description: "Dryers are not common in all countries, but they are a useful appliance for quickly drying clothes. Separate your laundry by fabric type and load the dryer evenly. Choose the correct drying cycle based on the fabric and desired level of dryness. Clean the lint filter after each use to ensure efficient operation.

My experience with dryers was initially very frustrating. My clothes would come out damp even after multiple cycles. After some research, I discovered the importance of cleaning the lint filter after every use. It turns out my roommates never did this, and the accumulated lint was preventing the dryer from working efficiently. Once I started cleaning the filter regularly, my clothes dried perfectly in one cycle."
  },
  {
    title: "The Benefits of a Humidifier",
    description: "A humidifier can help keep your home comfortable during the dry winter months by adding moisture to the air. This can alleviate dry skin, respiratory issues, and static electricity. Choose a humidifier that suits the size of your space and maintain it by regularly cleaning the water tank to prevent mold growth.

In my first winter, the air in my apartment was so dry that my skin felt constantly irritated and I had trouble sleeping. I bought a humidifier, and it made a world of difference. The added moisture in the air helped my skin feel better and improved my overall comfort."
  },
  {
    title: "Staying Warm with Proper Heating",
    description: "Proper heating is essential for staying warm in winter. Central heating systems, space heaters, and radiators are common options. Ensure your heating system is well-maintained and consider using a programmable thermostat to save energy and maintain a comfortable temperature. Insulate your home to retain heat and reduce energy costs.

The first winter, my apartment was always cold because I didn’t know how to use the heating system properly. After talking to my landlord, I learned how to adjust the settings and use a programmable thermostat. I also added weather stripping to the windows to reduce drafts. These changes made my apartment much warmer and more comfortable."
  },
  {
    title: "Overcoming Language Barriers in Montreal",
    description: "Language barriers can be challenging when settling in Montreal. Learn some basic phrases in French and practice regularly. Enroll in language classes or use online resources to improve your skills. Engage with the local community to practice speaking and gain confidence.

When I first moved here, the language barrier was intimidating. I took French classes and practiced speaking with locals. Over time, my confidence grew, and I was able to communicate more effectively. Engaging with the community and participating in language exchanges also helped me improve my skills."
  },
  {
    title: "Tipping Culture in Canada",
    description: "Tipping is an important part of Canadian culture, especially in the service industry. It is customary to tip around 15% to 20% of the bill in restaurants. Even if the service was not exceptional, a minimum tip is expected as servers rely on tips for their income. Be aware of tipping norms in other service areas like hair salons, taxis, and hotels.

When I first arrived, I was confused about tipping. In my home country, tipping was not as common. After some awkward experiences, I learned the importance of tipping in Canada and adjusted my habits accordingly. Now, I always make sure to tip appropriately when dining out or receiving services."
  },
  {
    title: "The Importance of Vitamin D",
    description: "Vitamin D is crucial for maintaining health, especially in winter when sunlight is limited. It helps with bone health, immune function, and mood regulation. Consider taking a vitamin D supplement or consuming foods rich in vitamin D, such as fatty fish, fortified dairy products, and egg yolks. Make an effort to spend time outside during daylight hours.

During my first winter, I felt constantly tired and down. I learned that this could be due to a lack of vitamin D from limited sunlight exposure. I started taking a vitamin D supplement and making an effort to spend time outside during the day. These changes improved my mood and energy levels significantly."
  },
  {
    title: "Staying Active in Winter",
    description: "Staying active in winter can be challenging, but it's important for physical and mental health. Engage in indoor activities like yoga, swimming, or gym workouts. Embrace outdoor winter sports like skiing, snowboarding, or ice skating. Dress warmly and stay safe while exercising outdoors.

I used to hibernate during the winter, avoiding outdoor activities. But I realized how important it was to stay active. I started attending indoor yoga classes and even tried skiing for the first time. Staying active helped me stay fit and improved my mental health during the long winter months."
  }
]

User.all.each do |user|
  topics.sample(2).each do |topic|
    article = Article.create!(
      title: topic[:title],
      description: topic[:description],
      user: user
    )

    url = "https://picsum.photos/800/600"
    file = URI.open(url)
    article.images.attach(io: file, filename: "article_#{article.id}.jpg", content_type: "image/jpeg")

    puts "Created article '#{article.title}' by #{user.first_name} #{user.last_name} with an image"
  end
end

puts "Creating events with images..."
events = [
  {
    title: "Shopping for Winter Coats on a Budget",
    description: "Join us for a guided shopping trip to find the best winter clothes. Learn about the different types of clothing and where to find good deals. Shops to visit: Winners, Marshalls, Sports Experts, and L'equipeur.",
    location: "1500 Avenue Atwater, Montreal, QC H3Z 1X5, Canada", # Alexis Nihon
    number_of_people_range: (5..30)
  },
  {
    title: "How to Get a Family Doctor",
    description: "Navigating the healthcare system can be challenging. Learn the steps to find and register with a family doctor in Montreal. The Zoom link will be shared in your email if you click going.",
    location: "Online",
    number_of_people_range: (5..30)
  },
  {
    title: "Biking in Winter Essentials",
    description: "Biking in winter requires special gear and preparation. Learn about the essentials for safe and enjoyable winter biking.",
    location: "27 Rue de la Commune E, Montreal, QC H2Y 1H9, Canada", # Ca Roule Montreal
    number_of_people_range: (5..30)
  },
  {
    title: "Guidance for Language Schools",
    description: "Learn about the various language schools in Montreal. Get tips on how to choose the right school and what to expect. The Zoom link will be shared in your email if you click going.",
    location: "Online",
    number_of_people_range: (5..30)
  },
  {
    title: "How to Land a Better Job: Improve Your CV",
    description: "Get valuable tips on how to improve your CV and increase your chances of landing a better job. The Zoom link will be shared in your email if you click going.",
    location: "Online",
    number_of_people_range: (5..30)
  },
  {
    title: "UEFA Champions League Game Gathering",
    description: "Join us to watch the UEFA Champions League game and cheer for your favorite team. Enjoy the match with fellow soccer enthusiasts.",
    location: "862 Rue Sainte-Catherine E, Montreal, QC H2L 2E3, Canada", # La Station des Sports
    number_of_people_range: (5..30)
  },
  {
    title: "Shopping for Winter Boots, Gloves, and Other Accessories",
    description: "Join us for a guided shopping trip to find the best winter boots, gloves, and accessories. Learn about the different types of winter gear and where to find good deals.",
    location: "9190 Boulevard de l'Acadie, Montreal, QC H4N 3H1, Canada", # Marché Central
    number_of_people_range: (5..30)
  },
  {
    title: "Mental Health: Symptoms That You May Be Suffering Depression",
    description: "Learn about the symptoms of depression and how to recognize them. The Zoom link will be shared in your email if you click going.",
    location: "Online",
    number_of_people_range: (5..30)
  },
  {
    title: "Understanding French Cursing Words",
    description: "Learn about common French cursing words and their meanings, mainly to understand them rather than use them. Examples include 'tabarnak', 'collise', 'ostie', etc.",
    location: "475 Boulevard de Maisonneuve E, Montreal, QC H2L 5C4, Canada", # BAnQ
    number_of_people_range: (5..30)
  },
  {
    title: "How to Choose a Car for Montreal",
    description: "Learn about the factors to consider when choosing a car for Montreal, such as all-wheel drive, car height, and driving in snowstorms. The Zoom link will be shared in your email if you click going.",
    location: "Online",
    number_of_people_range: (5..30)
  }
]

User.all.each do |user|
  event = events.sample
  created_event = Event.create!(
    title: event[:title],
    description: event[:description],
    location: event[:location],
    event_date: Date.today + rand(1..30),
    number_of_people: rand(event[:number_of_people_range]),
    user: user
  )

  file = URI.open("https://picsum.photos/800/600")
  created_event.images.attach(io: file, filename: "event_#{created_event.id}.jpg", content_type: "image/jpeg")

  puts "Created event '#{created_event.title}' with an image at #{created_event.location}"
end

puts "Finished creating events and articles!"
