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
  email: 'tukur0@gmail.com',
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
Category.all.each do |category|
  10.times do
    product = Product.create!(
      name: Faker::Commerce.product_name,
      description: Faker::Lorem.paragraph,
      price: Faker::Commerce.price(range: 10.0..100.0),
      stock_quantity: Faker::Number.between(from: 1, to: 100),
      category: category
    )
    product.image.attach(io: File.open(Rails.root.join('/home/tukuro/Ruby/Final_Pr/img/ichigo.jpg')), filename: 'ichigo.jpg') # Adjust the path
  end
end

# Seed addresses
User.all.each do |user|
  Address.create!(
    user: user,
    street: Faker::Address.street_address,
    city: Faker::Address.city,
    province: Faker::Address.state_abbr,
    postal_code: Faker::Address.zip_code
  )
end

# Seed tax rates
tax_data = [
  { province: 'AB', gst_rate: 5, hst_rate: 0 },
  { province: 'BC', gst_rate: 5, hst_rate: 7 },
  { province: 'MB', gst_rate: 5, hst_rate: 7 },
  { province: 'NB', gst_rate: 0, hst_rate: 15 },
  { province: 'NL', gst_rate: 0, hst_rate: 15 },
  { province: 'NT', gst_rate: 5, hst_rate: 0 },
  { province: 'NS', gst_rate: 0, hst_rate: 15 },
  { province: 'NU', gst_rate: 5, hst_rate: 0 },
  { province: 'ON', gst_rate: 0, hst_rate: 13 },
  { province: 'PE', gst_rate: 0, hst_rate: 15 },
  { province: 'QC', gst_rate: 5, hst_rate: 9.975 },
  { province: 'SK', gst_rate: 5, hst_rate: 6 },
  { province: 'YT', gst_rate: 5, hst_rate: 0 }
]

tax_data.each do |data|
  Tax.create!(
    province: data[:province],
    gst_rate: data[:gst_rate],
    hst_rate: data[:hst_rate]
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

  tax_rate = Tax.find_by(province: address.province)
  if tax_rate
    order.gst = order.subtotal * (tax_rate.gst_rate / 100.0)
    order.hst = order.subtotal * (tax_rate.hst_rate / 100.0)
  else
    order.gst = 0
    order.hst = 0
  end
  order.total_price = order.subtotal + order.gst + order.hst
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

puts "Database seeded successfully!"
