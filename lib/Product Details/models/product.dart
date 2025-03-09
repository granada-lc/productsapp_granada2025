class Product {  // Product model class

  final String name, description, image;  // Product details
  final double price, rating;  // Price and rating
  final int reviews;  // Number of reviews

  Product({  
    required this.name,  // Name
    required this.description,  // Description
    required this.image,  // Image URL
    required this.price,  // Price
    required this.rating,  // Rating
    required this.reviews,  // Reviews count
  });
}
