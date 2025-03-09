import 'package:flutter/material.dart';  // Flutter UI package
import '../models/product.dart';  // Import product model

class ProductInfo extends StatelessWidget {  // Product info widget
  final Product product;  // Product data
  const ProductInfo({required this.product, super.key});  // Constructor

  @override
  Widget build(BuildContext context) {  // Build UI
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),  // Add padding
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,  // Align content to start
        children: [
          Row(  // Row for brand, rating, and favorite icon
            children: [
              const Text("Nike", style: TextStyle(color: Colors.grey)),  // Brand name
              const SizedBox(width: 10),  // Spacing
              const Icon(Icons.star, color: Colors.orange, size: 16),  // Star icon
              Text(" ${product.rating} (${product.reviews})", style: const TextStyle(color: Colors.grey)),  // Rating and reviews
              const Spacer(),  // Push favorite icon to the right
              const Icon(Icons.favorite_border, color: Colors.black),  // Favorite icon
            ],
          ),
          const SizedBox(height: 5),  // Spacing
          Text(
            product.name,  // Product name
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          Text(
            product.description,  // Product description
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 5),  // Spacing
          Text(
            "₱${product.price}",  // Product price
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
