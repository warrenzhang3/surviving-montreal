# require 'open-uri'

puts "Cleaning database..."
Article.destroy_all
Event.destroy_all
Badge.destroy_all
User.destroy_all

puts "Creating users..."
users = [
  { first_name: "Diego", last_name: "Arriaga", profile_pic_url: "https://a.espncdn.com/combiner/i?img=/i/headshots/college-football/players/full/5084180.png" },
  { first_name: "Zoe", last_name: "Martinez", profile_pic_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2oEvUGqQV26yrc29qyEcdVPMNuBRK7_0UMg&s" },
  { first_name: "Gael", last_name: "Marcoux", profile_pic_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTH8RITC5W2LdMIGiDFEDniWJtjvzYTX-7C7Q&s" },
  { first_name: "Ana", last_name: "Dos Santos", profile_pic_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT0RhxkExefT0sYkvhsMMlMGD9U9iLRMWPVVA&s" },
  { first_name: "Leonardo", last_name: "Diaz", profile_pic_url: "https://images.vogue.it/users/my/avatar/leonardosantetti.png?v=1664780488" },
  { first_name: "Sofia", last_name: "Zapata", profile_pic_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-CCv6oVo_UCGR4ne5pQieWleRcWQtkgiKFA&s" },
  { first_name: "Alfonso", last_name: "Carreto", profile_pic_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-Yh64jiz6_vPNdoTDkdMvq-WyaZfnlCre7g&s" },
  { first_name: "Laura", last_name: "Serrano", profile_pic_url: "https://images.crunchbase.com/image/upload/c_thumb,h_256,w_256,f_auto,g_face,z_0.7,q_auto:eco,dpr_1/v1442464401/jzco7792vfyr7nsgrrpo.png" },
  { first_name: "Carlos", last_name: "Cruz", profile_pic_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSGgQ3N5zwn8pTguzokOPdbBEQN1c3Qq0k9kw&s" },
  { first_name: "Lucia", last_name: "Oliveira", profile_pic_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSTkuY7GZyb8NigUpPvzvJi2VhR2GIJnkTugg&s" }
]

users.each_with_index do |user_data, i|
  user = User.create!(
    first_name: user_data[:first_name],
    last_name: user_data[:last_name],
    email: "user#{i+1}@example.com",
    year_of_arrival: Date.new(rand(2010..2023), 1, 1),
    password: "password",
    password_confirmation: "password"
  )

  user.profile_pic.attach(io: URI.parse(user_data[:profile_pic_url]).open, filename: "profile_pic_#{i+1}.jpg", content_type: "image/jpeg")

  puts "Created user #{user.first_name} #{user.last_name}"
end

puts "Creating articles..."
articles = [
  { title: "Choosing the Right Winter Boots", description: "Choosing the right winter boots can make a huge difference in staying warm and comfortable during the harsh Montreal winters. Look for boots that offer insulation, waterproof materials, and good traction to prevent slips on icy surfaces. Consider the height of the boot to ensure it covers your ankles and lower legs for added warmth.\n\nLast winter, I found myself slipping all over the place with my old boots. They weren’t waterproof either, so my feet were always cold and wet. Then I learned about the importance of proper winter boots. After some research, I bought a pair with good insulation and waterproofing. It made all the difference. I could walk confidently on icy sidewalks and my feet stayed warm and dry all day.", image_url: "https://d1nymbkeomeoqg.cloudfront.net/photos/27/62/397765_27073_XL.jpg" },
  { title: "Using a Dishwasher", description: "A dishwasher can save you a lot of time and effort in the kitchen. To use a dishwasher effectively, load it properly with dishes facing inward and avoid overcrowding. Use the appropriate detergent and select the right cycle for the level of soiling. Regularly clean the dishwasher filter to maintain its efficiency. When I first encountered a dishwasher, I was clueless about how to use it properly. My roommates advised me to just throw everything in and let it run. After a few cycles, I noticed the dishes weren’t getting clean. I researched a bit and found out I needed to load it correctly and clean the filter regularly. After that, my dishes came out sparkling clean.", image_url: "https://library.homeserve.com/m/4f91025c467437b/Blog-GettyImages-117145033.jpg" },
  { title: "How to Operate a Dryer", description: "Dryers are not common in all countries, but they are a useful appliance for quickly drying clothes. Separate your laundry by fabric type and load the dryer evenly. Choose the correct drying cycle based on the fabric and desired level of dryness. Clean the lint filter after each use to ensure efficient operation. My experience with dryers was initially very frustrating. My clothes would come out damp even after multiple cycles. After some research, I discovered the importance of cleaning the lint filter after every use. It turns out my roommates never did this, and the accumulated lint was preventing the dryer from working efficiently. Once I started cleaning the filter regularly, my clothes dried perfectly in one cycle.", image_url: "https://www.ambientbp.com/blog/wp-content/uploads/2018/01/dryer-lint-e1515711153339.jpg" },
  { title: "Staying Warm with Proper Heating", description: "Proper heating is essential for staying warm in winter. Central heating systems, space heaters, and radiators are common options. Ensure your heating system is well-maintained and consider using a programmable thermostat to save energy and maintain a comfortable temperature. Insulate your home to retain heat and reduce energy costs. The first winter, my apartment was always cold because I didn’t know how to use the heating system properly. After talking to my landlord, I learned how to adjust the settings and use a programmable thermostat. I also added weather stripping to the windows to reduce drafts. These changes made my apartment much warmer and more comfortable.", image_url: "https://www.thespruce.com/thmb/Lef58DPmVpKNBDf3HyCeCcLVADg=/2037x0/filters:no_upscale():max_bytes(150000):strip_icc()/solenoid-valve-on-two-pipe-steam-radiator-via-smallspaces.about.com-56a8894a5f9b58b7d0f32505.jpg" },
  { title: "The Benefits of a Humidifier", description: "A humidifier can help keep your home comfortable during the dry winter months by adding moisture to the air. This can alleviate dry skin, respiratory issues, and static electricity. Choose a humidifier that suits the size of your space and maintain it by regularly cleaning the water tank to prevent mold growth. In my first winter, the air in my apartment was so dry that my skin felt constantly irritated and I had trouble sleeping. I bought a humidifier, and it made a world of difference. The added moisture in the air helped my skin feel better and improved my overall comfort.", image_url: "https://djd1xqjx2kdnv.cloudfront.net/photos/38/2/501731_12614_XL.jpg" },
  { title: "Overcoming Language Barriers in Montreal", description: "Language barriers can be challenging when settling in Montreal. Learn some basic phrases in French and practice regularly. Enroll in language classes or use online resources to improve your skills. Engage with the local community to practice speaking and gain confidence. When I first moved here, the language barrier was intimidating. I took French classes and practiced speaking with locals. Over time, my confidence grew, and I was able to communicate more effectively. Engaging with the community and participating in language exchanges also helped me improve my skills.", image_url: "https://www.mcgilldaily.com/wp-content/uploads/2024/09/AnglophoneArticle-1.jpg" },
  { title: "Finding the Perfect Winter Coat", description: "A good winter coat is essential for braving the cold in Montreal. When selecting a coat, consider factors such as insulation, waterproofing, and wind resistance. Down coats provide excellent warmth, while synthetic insulation is a great alternative for those who prefer not to use animal products. Make sure the coat fits well and allows for layering.\n\nI remember my first winter here, I had a thin jacket that wasn’t nearly warm enough. I would layer up with sweaters underneath, but it still wasn’t enough. Eventually, I invested in a proper winter coat with down insulation and a waterproof exterior. The difference was incredible. I could actually enjoy being outside in the cold without shivering.", image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXnzfhAI5TgOoQkMquvhnPA7NdAcMhcm6CCg&s" },
  { title: "Tipping Culture in Canada", description: "Tipping is an important part of Canadian culture, especially in the service industry. It is customary to tip around 15% to 20% of the bill in restaurants. Even if the service was not exceptional, a minimum tip is expected as servers rely on tips for their income. Be aware of tipping norms in other service areas like hair salons, taxis, and hotels. When I first arrived, I was confused about tipping. In my home country, tipping was not as common. After some awkward experiences, I learned the importance of tipping in Canada and adjusted my habits accordingly. Now, I always make sure to tip appropriately when dining out or receiving services.", image_url: "https://images.radio-canada.ca/q_auto,w_635/v1/ici-info/16x9/tip-machine.png" },
  { title: "The Importance of Vitamin D", description: "Vitamin D is crucial for maintaining health, especially in winter when sunlight is limited. It helps with bone health, immune function, and mood regulation. Consider taking a vitamin D supplement or consuming foods rich in vitamin D, such as fatty fish, fortified dairy products, and egg yolks. Make an effort to spend time outside during daylight hours. During my first winter, I felt constantly tired and down. I learned that this could be due to a lack of vitamin D from limited sunlight exposure. I started taking a vitamin D supplement and making an effort to spend time outside during the day. These changes improved my mood and energy levels significantly.", image_url: "https://images.twnmm.com/c55i45ef3o2a/5uH0pT2GwjxZzNipv58uOl/202224646d420fa39952ed482cd4ee0a/gettyimages-1129009121-170667a.jpg?fm=webp&q=80&w=3840" },
  { title: "Staying Active in Winter", description: "Staying active in winter can be challenging, but it's important for physical and mental health. Engage in indoor activities like yoga, swimming, or gym workouts. Embrace outdoor winter sports like skiing, snowboarding, or ice skating. Dress warmly and stay safe while exercising outdoors. I used to hibernate during the winter, avoiding outdoor activities. But I realized how important it was to stay active. I started attending indoor yoga classes and even tried skiing for the first time. Staying active helped me stay fit and improved my mental health during the long winter months.", image_url: "https://s3.ca-central-1.amazonaws.com/files.quartierdesspectacles.com/lieux/esplanade-tranquille/esplanade-tranquille-qds-inauguration-c-ulysse-lemerise-osa-hr-11-852x350.jpg" },
]

users = User.all
articles.each_with_index do |article_data, i|
  article = Article.create!(
    title: article_data[:title],
    description: article_data[:description],
    user: users[i]
  )

  article.images.attach(io: URI.parse(article_data[:image_url]).open, filename: "article_#{i+1}.jpg", content_type: "image/jpeg")

  puts "Created article '#{article.title}' for user #{users[i].first_name} #{users[i].last_name}"
end

puts "Creating events with images..."
events = [
  { title: "Shopping for Winter Coats on a Budget", description: "Join us for a guided shopping trip to find the best winter clothes. Learn about the different types of clothing and where to find good deals. Shops to visit: Winners, Marshalls, Sports Experts, and L'equipeur.", location: "1500 Avenue Atwater, Montreal, QC H3Z 1X5, Canada", image_url: "https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/Place_Alexis-Nihon_03.JPG/2560px-Place_Alexis-Nihon_03.JPG", number_of_people_range: (5..30) },
  { title: "How to Get a Family Doctor", description: "Navigating the healthcare system can be challenging. Learn the steps to find and register with a family doctor in Montreal. The Zoom link will be shared in your email if you click going.", location: "Online", image_url: "https://wp.globaluniversitysystems.com/mua/wp-content/uploads/sites/10/2023/02/istock-482499394.webp", number_of_people_range: (5..30) },
  { title: "Biking in Winter Essentials", description: "Biking in winter requires special gear and preparation. Learn about the essentials for safe and enjoyable winter biking.", location: "27 Rue de la Commune E, Montreal, QC H2Y 1H9, Canada", image_url: "https://images.ctfassets.net/761l7gh5x5an/5Kun3Vx7niHN1KlKivAJmu/ebf92598546c565ff493d91e2ea3228f/Copie_de_20230216_A_507.jpg?f=&fit=thumb&q=80&fl=progressive&w=1200&h=800", number_of_people_range: (5..30) },
  { title: "Guidance for Language Schools", description: "Learn about the various language schools in Montreal. Get tips on how to choose the right school and what to expect. The Zoom link will be shared in your email if you click going.", location: "Online", image_url: "https://cdeacf.ca/sites/default/files/image_resume/fxtugvdxwaaxarw.jpg", number_of_people_range: (5..30) },
  { title: "How to Land a Better Job: Improve Your CV", description: "Get valuable tips on how to improve your CV and increase your chances of landing a better job. The Zoom link will be shared in your email if you click going.", location: "Online", image_url: "https://positiveroutines.com/wp-content/uploads/2019/08/two-people-working-together-in-office.jpg", number_of_people_range: (5..30) },
  { title: "Understanding Hockey", description: "Join us to watch a hockey game while a hockey expert explains the rules. It's a great opportunity to understand the game better and enjoy it with fellow enthusiasts.", location: "862 Rue Sainte-Catherine E, Montreal, QC H2L 2E3, Canada", image_url: "https://cdn.sanity.io/images/rizm0do5/production/4d7500b65474b1212a04f36cd7fc35874bdeb993-2048x1158.jpg?rect=330,0,1718,1158&w=690&h=465&q=80&fit=clip&auto=format", number_of_people_range: (5..30) },
  { title: "Shopping for Winter Boots, Gloves, and Other Accessories", description: "Join us for a guided shopping trip to find the best winter boots, gloves, and accessories. Learn about the different types of winter gear and where to find good deals.", location: "9190 Boulevard de l'Acadie, Montreal, QC H4N 3H1, Canada", image_url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQDaKLkI62SE1SLrNDsnI123DRFeTrsJCtg8g&s", number_of_people_range: (5..30) },
  { title: "Mental Health: Symptoms That You May Be Suffering Depression", description: "Learn about the symptoms of depression and how to recognize them. The Zoom link will be shared in your email if you click going.", location: "Online", image_url: "https://images.ctfassets.net/h8qzhh7m9m8u/3VobuvkO6KVEJr83zA3nPn/e3e9fd8e6372fb1dd6c459ef01bd6527/SAD.jpg", number_of_people_range: (5..30) },
  { title: "Understanding French Cursing Words", description: "Learn about common French cursing words and their meanings, mainly to understand them rather than use them. Examples include 'tabarnak', 'collise', 'ostie', etc.", location: "475 Boulevard de Maisonneuve E, Montreal, QC H2L 5C4, Canada", image_url: "https://www.mtlblog.com/media-library/drawing-showing-a-religious-chalice-and-a-farmer-screaming-a-swear-word.jpg?id=26807836&width=1245&height=700&coordinates=0%2C2%2C0%2C2", number_of_people_range: (5..30) },
  { title: "How to Choose a Car for Montreal", description: "Learn about the factors to consider when choosing a car for Montreal, such as all-wheel drive, car height, and driving in snowstorms. The Zoom link will be shared in your email if you click going.", location: "Online", image_url: "https://s.abcnews.com/images/US/cold-weather-driving-gty-jc-190130_hpMain.jpg", number_of_people_range: (5..30) }
]

users = User.all
events.each_with_index do |event_data, i|
  event = Event.create!(
    title: event_data[:title],
    description: event_data[:description],
    location: event_data[:location],
    event_date: Date.today + rand(1..30),
    number_of_people: rand(event_data[:number_of_people_range]),
    user: users[i]
  )

  event.images.attach(io: URI.parse(event_data[:image_url]).open, filename: "event_#{i+1}.jpg", content_type: "image/jpeg")

  puts "Created event '#{event.title}' for user #{users[i].first_name} #{users[i].last_name}"
end

puts "Finished creating events and articles!"

puts "Finished creating events and articles!"

# Create Ribot's user account
ribot = User.create!(
  first_name: "Ribot",
  last_name: "T.",
  email: "ribot@email.com",
  password: "123456",
  password_confirmation: "123456"
)

generic_profile_pic_url = "https://img.freepik.com/free-vector/blue-circle-with-white-user_78370-4707.jpg?semt=ais_hybrid"
ribot.profile_pic.attach(io: URI.parse(generic_profile_pic_url).open, filename: "generic_profile_pic.jpg", content_type: "image/jpeg")

puts "Created Ribot's user account"

puts 'creating badges'

Badge.create!(
  name: 'First Article',
  description: 'Congratulations! You’ve taken your first step into the world of writing by publishing your very first article. Keep up the great work and continue sharing your insights!',
  image: 'first_article.png'
)

Badge.create!(
  name: 'Attend Your First Event',
  description: 'Well done! You’ve taken the initiative to attend your first event. Keep participating and making the most out of these experiences. Your journey has just begun!',
  image: 'first_event.png'
)

Badge.create!(
  name: 'Survive Your First Winter',
  description: 'Bravo! You’ve successfully navigated through your first winter. From chilly winds to snowy days, you’ve proven your resilience. Keep embracing the adventure!',
  image: 'first_winter.png'
)

Badge.create!(
  name: 'First Event Create',
  description: 'Fantastic job! You’ve successfully organized and created your very first event. This badge is a testament to your initiative and leadership. Keep up the great work and continue bringing people together!',
  image: 'first_event_create.png'
)
