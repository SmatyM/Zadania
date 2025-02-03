# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ClothingDashboard1.Repo.insert!(%ClothingDashboard1.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias ClothingDashboard1.Repo
alias ClothingDashboard1.Catalog.Product

products = [
  %{
    title: "Classic White T-Shirt",
    description: "A timeless white t-shirt for everyday wear.",
    category: "Clothing",
    price: Decimal.new("19.99"),
    stock: 100,
    photo: "/images/white_tshirt.jpg",
    sold_count: 30,
    transaction_dates: [~U[2025-01-10 14:00:00Z], ~U[2025-01-15 18:30:00Z]]
  },
  %{
    title: "Denim Jacket",
    description: "Stylish blue denim jacket with pockets.",
    category: "Outerwear",
    price: Decimal.new("49.99"),
    stock: 50,
    photo: "/images/denim_jacket.jpg",
    sold_count: 20,
    transaction_dates: [~U[2025-01-05 12:45:00Z], ~U[2025-01-20 09:15:00Z]]
  },
  %{
    title: "Running Shoes",
    description: "Comfortable running shoes for daily training.",
    category: "Footwear",
    price: Decimal.new("59.99"),
    stock: 75,
    photo: "/images/running_shoes.jpg",
    sold_count: 40,
    transaction_dates: [~U[2025-02-01 08:00:00Z], ~U[2025-02-05 10:30:00Z]]
  },
  %{
    title: "Leather Wallet",
    description: "Genuine leather wallet with multiple card slots.",
    category: "Accessories",
    price: Decimal.new("29.99"),
    stock: 30,
    photo: "/images/leather_wallet.jpg",
    sold_count: 15,
    transaction_dates: [~U[2025-02-10 16:45:00Z]]
  },
  %{
    title: "Black Jeans",
    description: "Slim-fit black jeans made with premium cotton.",
    category: "Clothing",
    price: Decimal.new("39.99"),
    stock: 60,
    photo: "/images/black_jeans.jpg",
    sold_count: 25,
    transaction_dates: [~U[2025-01-25 14:10:00Z], ~U[2025-02-01 19:20:00Z]]
  },
  %{
    title: "Hoodie Sweatshirt",
    description: "Warm and cozy hoodie for casual wear.",
    category: "Clothing",
    price: Decimal.new("45.99"),
    stock: 80,
    photo: "/images/hoodie.jpg",
    sold_count: 35,
    transaction_dates: [~U[2025-01-18 15:00:00Z], ~U[2025-01-22 11:45:00Z]]
  },
  %{
    title: "Baseball Cap",
    description: "Classic adjustable cap with breathable fabric.",
    category: "Accessories",
    price: Decimal.new("15.99"),
    stock: 120,
    photo: "/images/baseball_cap.jpg",
    sold_count: 50,
    transaction_dates: [~U[2025-01-12 17:30:00Z], ~U[2025-01-28 08:25:00Z]]
  },
  %{
    title: "Smartwatch",
    description: "Feature-packed smartwatch with fitness tracking.",
    category: "Electronics",
    price: Decimal.new("99.99"),
    stock: 40,
    photo: "/images/smartwatch.jpg",
    sold_count: 10,
    transaction_dates: [~U[2025-02-03 20:15:00Z]]
  },
  %{
    title: "Winter Gloves",
    description: "Insulated gloves to keep your hands warm.",
    category: "Accessories",
    price: Decimal.new("22.99"),
    stock: 70,
    photo: "/images/winter_gloves.jpg",
    sold_count: 22,
    transaction_dates: [~U[2025-01-30 07:10:00Z], ~U[2025-02-02 13:45:00Z]]
  },
  %{
    title: "Sports Water Bottle",
    description: "Reusable and BPA-free water bottle for hydration.",
    category: "Accessories",
    price: Decimal.new("12.99"),
    stock: 150,
    photo: "/images/water_bottle.jpg",
    sold_count: 75,
    transaction_dates: [~U[2025-01-08 10:20:00Z], ~U[2025-01-26 16:00:00Z]]
  }
]

Enum.each(products, fn product_attrs ->
  %Product{}
  |> Product.changeset(product_attrs)
  |> Repo.insert!()
end)

IO.puts("✅ 10 sample products inserted successfully!")
