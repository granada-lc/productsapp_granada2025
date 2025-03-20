import 'package:flutter/material.dart';
import 'product_details.dart';
import 'product.dart';

// Category Button Widget
class CategoryButton extends StatelessWidget {
  final String title; // Title of the category button
  const CategoryButton({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(title, style: const TextStyle(fontSize: 14)), // Category label
      backgroundColor: Colors.orange[100], // Background color
    );
  }
}

// Product Card Widget
class ProductCard extends StatelessWidget {
  final Product product; // Product data
  const ProductCard({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigate to DetailScreen when a product is clicked
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(product: product), // Pass product data
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align text to start
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.yellow[100], // Background color
                borderRadius: BorderRadius.circular(10), // Rounded corners
                image: DecorationImage(
                  image: AssetImage(product.image), // Display product image
                  fit: BoxFit.cover, // Cover the box
                ),
              ),
            ),
          ),
          const SizedBox(height: 8), // Space between image and text
          Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)), // Product name
          Text(product.description, style: const TextStyle(fontSize: 12, color: Colors.grey)), // Product description
          Text("₱${product.price}", style: const TextStyle(fontWeight: FontWeight.bold)), // Product price
        ],
      ),
    );
  }
}

// Home Screen
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[100], // App bar color
        elevation: 0, // Remove shadow
        leading: const Icon(Icons.menu, color: Colors.black), // Menu icon
        actions: const [
          Icon(Icons.notifications_none, color: Colors.black), // Notification icon
          SizedBox(width: 16), // Space on right side
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding around content
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align items to start
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between category buttons
              children: ["Jacket", "Bags", "Shirt", "Hat"]
                  .map((category) => CategoryButton(title: category)) // Create category buttons
                  .toList(),
            ),
            const SizedBox(height: 20), // Space below category buttons
            const Text("Most Popular", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), // Section title
            const SizedBox(height: 10), // Space below title
            Expanded(
              child: GridView.builder(
                itemCount: products.length, // Number of products
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns in the grid
                  childAspectRatio: 0.7, // Aspect ratio of grid items
                  crossAxisSpacing: 12, // Space between columns
                  mainAxisSpacing: 12, // Space between rows
                ),
                itemBuilder: (context, index) {
                  return ProductCard(product: products[index]); // Create product cards
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
    
