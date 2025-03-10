class Product {
  final String name, description, image;
  final double price, rating;
  final int reviews;

  Product({
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.rating,
    required this.reviews,
  });
}

// Sample product data
List<Product> products = [
  Product(
    name: "Nike Strike+",
    description: "Men's Jacket",
    image: "assets/jacket.png",
    price: 4295,
    rating: 4.9,
    reviews: 590,
  ),
  Product(
    name: "Nike T-Shirt",
    description: "Women's Logo Tee",
    image: "assets/shirt.png",
    price: 1395,
    rating: 4.5,
    reviews: 320,
  ),
  Product(
    name: "Nike Apex Hat",
    description: "Swoosh Bucket Hat",
    image: "assets/hat.png",
    price: 2262,
    rating: 4.8,
    reviews: 250,
  ),
  Product(
    name: "Jordan Essentials",
    description: "Men's Woven Trousers",
    image: "assets/trousers.png",
    price: 6903,
    rating: 4.7,
    reviews: 180,
  ),
  Product(
    name: "Nike Backpack",
    description: "33L Utility Power",
    image: "assets/backpack.png",
    price: 8644,
    rating: 4.9,
    reviews: 600,
  ),
  Product(
    name: "Nike Heritage",
    description: "Cross-Body Bag (4L)",
    image: "assets/bag.png",
    price: 2030,
    rating: 4.6,
    reviews: 200,
  ),
];
