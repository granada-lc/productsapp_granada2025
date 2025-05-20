class Product {
  final int id; // Add an ID for API usage
  final String name;
  final String description;
  final String image; // Use this for local sample data
  final double price;
  final double rating;
  final int reviews;
  final String? imagePath; // Use this for API data
  final int? categoryId; // <-- Add this line

  // Constructor for local data
  Product({
    this.id = 0, // Default value for local use
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.rating,
    required this.reviews,
    this.imagePath,
    this.categoryId, // <-- Add this line
  });

  // Factory method to create a Product from JSON
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      image: json['image_path'] ??
          '', // Fallback to an empty string if not present
      price: double.parse(json['price'].toString()),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviews: json['reviews'] ?? 0,
      imagePath: json['image_path'],
      categoryId: json['category_id'], // <-- Add this line
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image_path': imagePath ?? image,
      'price': price,
      'rating': rating,
      'reviews': reviews,
      'category_id': categoryId, // <-- Add this line
    };
  }
}

// Sample product data for local use
List<Product> products = [
  Product(
    id: 1,
    name: "Nike Strike+",
    description: "Men's Jacket",
    image: "assets/jacket.png",
    price: 4295,
    rating: 4.9,
    reviews: 590,
  ),
  Product(
    id: 2,
    name: "Nike T-Shirt",
    description: "Women's Logo Tee",
    image: "assets/shirt.png",
    price: 1395,
    rating: 4.5,
    reviews: 320,
  ),
  Product(
    id: 3,
    name: "Nike Apex Hat",
    description: "Swoosh Bucket Hat",
    image: "assets/hat.png",
    price: 2262,
    rating: 4.8,
    reviews: 250,
  ),
  Product(
    id: 4,
    name: "Jordan Essentials",
    description: "Men's Woven Trousers",
    image: "assets/trousers.png",
    price: 6903,
    rating: 4.7,
    reviews: 180,
  ),
  Product(
    id: 5,
    name: "Nike Backpack",
    description: "33L Utility Power",
    image: "assets/backpack.png",
    price: 8644,
    rating: 4.9,
    reviews: 600,
  ),
  Product(
    id: 6,
    name: "Nike Heritage",
    description: "Cross-Body Bag (4L)",
    image: "assets/bag.png",
    price: 2030,
    rating: 4.6,
    reviews: 200,
  ),
];
