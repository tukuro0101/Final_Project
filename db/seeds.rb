require 'faker'

# Clear existing data
OrderItem.destroy_all
Order.destroy_all
Review.destroy_all
CartItem.destroy_all
Cart.destroy_all
Address.destroy_all
Product.destroy_all
Category.destroy_all
User.destroy_all
Tax.destroy_all
Province.destroy_all
TaxType.destroy_all
StaticPage.destroy_all

# Seed provinces
provinces = ["Alberta", "British Columbia", "Manitoba", "New Brunswick", "Newfoundland and Labrador", "Northwest Territories", "Nova Scotia", "Nunavut", "Ontario", "Prince Edward Island", "Quebec", "Saskatchewan", "Yukon"]
provinces.each do |province|
  Province.create!(name: province)
end

# Seed tax types
gst = TaxType.create!(type_name: "GST")
hst = TaxType.create!(type_name: "HST")
pst = TaxType.create!(type_name: "PST")
qst = TaxType.create!(type_name: "QST")

# Seed taxes
Province.all.each do |province|
  Tax.create!(province: province, tax_type: gst, rate: 5.0)
  Tax.create!(province: province, tax_type: hst, rate: 15.0) if ["New Brunswick", "Newfoundland and Labrador", "Nova Scotia", "Ontario", "Prince Edward Island"].include?(province.name)
  Tax.create!(province: province, tax_type: pst, rate: 7.0) if ["British Columbia", "Manitoba", "Saskatchewan"].include?(province.name)
  Tax.create!(province: province, tax_type: qst, rate: 9.975) if province.name == "Quebec"
end

# Seed users
10.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.unique.email,
    phone_number: Faker::PhoneNumber.cell_phone,
    password: 'password',
    role: ['user', 'admin'].sample
  )
end

User.create!(
  email: 'tukuro@gmail.com',
  password: 'rukia2323',
  password_confirmation: 'rukia2323',
  admin: true
)

# Seed categories
categories = ['Figures', 'Posters', 'Accessories', 'Apparel', 'Games']
categories.each do |category|
  Category.create!(name: category)
end

# Seed products
categories.each do |category|
  10.times do
    product = Product.create!(
      name: Faker::Commerce.product_name,
      description: Faker::Lorem.paragraph,
      price: Faker::Commerce.price(range: 10.0..100.0),
      stock_quantity: Faker::Number.between(from: 1, to: 100),
      category: Category.find_by(name: category)
    )
    product.image.attach(io: File.open(Rails.root.join('/home/tukuro/Ruby/Final_Pr/img/ichigo.jpg')), filename: 'ichigo.jpg')
  end
end

if Product.count < 100
  (100 - Product.count).times do
    product = Product.create!(
      name: Faker::Commerce.product_name,
      description: Faker::Lorem.paragraph,
      price: Faker::Commerce.price(range: 10.0..100.0),
      stock_quantity: Faker::Number.between(from: 1, to: 100),
      category: Category.all.sample
    )
    product.image.attach(io: File.open(Rails.root.join('/home/tukuro/Ruby/Final_Pr/img/ichigo.jpg')), filename: 'ichigo.jpg')
  end
end

# Seed addresses
User.all.each do |user|
  Address.create!(
    user: user,
    street: Faker::Address.street_address,
    city: Faker::Address.city,
    province: Province.order('RANDOM()').first, # Assign a random province
    postal_code: Faker::Address.zip_code
  )
end

# Seed orders, order items, and reviews
User.all.each do |user|
  address = user.addresses.sample
  order = Order.create!(
    user: user,
    address: address,
    subtotal: 0,
    gst: 0,
    hst: 0,
    pst: 0,
    qst: 0,
    total_price: 0,
    status: ['pending', 'completed', 'shipped', 'cancelled'].sample
  )

  3.times do
    product = Product.all.sample
    quantity = Faker::Number.between(from: 1, to: 5)
    price = product.price * quantity
    OrderItem.create!(
      order: order,
      product: product,
      quantity: quantity,
      price: price
    )
    order.subtotal += price
  end

  province_taxes = address.province.taxes
  gst_rate = province_taxes.find_by(tax_type: gst)&.rate || 0
  hst_rate = province_taxes.find_by(tax_type: hst)&.rate || 0
  pst_rate = province_taxes.find_by(tax_type: pst)&.rate || 0
  qst_rate = province_taxes.find_by(tax_type: qst)&.rate || 0

  order.gst = order.subtotal * (gst_rate / 100.0)
  order.hst = order.subtotal * (hst_rate / 100.0)
  order.pst = order.subtotal * (pst_rate / 100.0)
  order.qst = order.subtotal * (qst_rate / 100.0)

  order.total_price = order.subtotal + order.gst + order.hst + order.pst + order.qst
  order.save!

  # Seed reviews
  2.times do
    product = Product.all.sample
    Review.create!(
      product: product,
      user: user,
      rating: Faker::Number.between(from: 1, to: 5),
      comment: Faker::Lorem.sentence
    )
  end

  # Seed cart and cart items
  cart = Cart.create!(user: user)
  3.times do
    product = Product.all.sample
    quantity = Faker::Number.between(from: 1, to: 5)
    CartItem.create!(
      cart: cart,
      product: product,
      quantity: quantity
    )
  end
end

StaticPage.create!(title: 'Contact', content: 'Contact us at contact@example.com.')
StaticPage.create!(title: 'About', content: 'We are a fictional store created for a Rails project.')
puts "Database seeded successfully!"
