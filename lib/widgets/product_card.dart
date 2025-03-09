import 'package:flutter/material.dart'; // Import Flutter material package.
import '../models/product.dart'; // Import the Product model.

class ProductCard extends StatelessWidget {
  final Product product; // Product data to display.

  const ProductCard({required this.product, super.key}); // Constructor with required product.

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Align content to the left.
      children: [
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.yellow[100], // Background color as a fallback.
              borderRadius: BorderRadius.circular(10), // Rounded corners.
              image: DecorationImage(
                image: AssetImage(product.image), // Load product image from assets.
                fit: BoxFit.cover, // Cover the container fully.
              ),
            ),
          ),
        ),
        const SizedBox(height: 8), // Spacing below the image.

        Text(
          product.name, // Display product name.
          style: const TextStyle(fontWeight: FontWeight.bold), // Bold text style.
        ),
        
        Text(
          product.description, // Display product description.
          style: const TextStyle(fontSize: 12, color: Colors.grey), // Smaller grey text.
        ),
        
        Text(
          "₱${product.price}", // Display product price with currency symbol.
          style: const TextStyle(fontWeight: FontWeight.bold), // Bold price text.
        ),
      ],
    );
  }
}
