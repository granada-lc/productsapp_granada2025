import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product.dart';
import 'app_state.dart';

// Product Image Widget
class ProductImage extends StatelessWidget {
  final String image; // Product image path
  const ProductImage({required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300, // Image container height
      decoration: BoxDecoration(
        color: Colors.pink[100], // Background color
        image: DecorationImage(
          image: AssetImage(image), // Load image from assets
          fit: BoxFit.contain, // Fit inside container
        ),
      ),
    );
  }
}

// Product Info Widget
class ProductInfo extends StatelessWidget {
  final Product product; // Product data
  const ProductInfo({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Add spacing
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align text to left
        children: [
          Row(
            children: [
              const Text("Nike", style: TextStyle(color: Colors.grey)), // Brand name
              const SizedBox(width: 10), // Space between brand and rating
              const Icon(Icons.star, color: Colors.orange, size: 16), // Star icon
              Text(" ${product.rating} (${product.reviews})", style: const TextStyle(color: Colors.grey)), // Rating & reviews
              const Spacer(), // Push favorite icon to the right
              const Icon(Icons.favorite_border, color: Colors.black), // Favorite icon
            ],
          ),
          const SizedBox(height: 5), // Space
          Text(product.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)), // Product name
          Text(product.description, style: const TextStyle(color: Colors.grey)), // Product description
          const SizedBox(height: 5), // Space
          Text("₱${product.price}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)), // Product price
        ],
      ),
    );
  }
}

// Category Selector Widget
class CategorySelector extends StatelessWidget {
  const CategorySelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Add spacing
      child: Row(
        children: ["Clothing", "Shoes", "Jewelry"]
            .map((category) => Padding(
                  padding: const EdgeInsets.only(right: 8), // Space between chips
                  child: Chip(label: Text(category)), // Category chip
                ))
            .toList(),
      ),
    );
  }
}

// Color Selector Widget
class ColorSelector extends StatelessWidget {
  const ColorSelector({super.key});

  @override
  Widget build(BuildContext context) {

    final appState = Provider.of<AppState>(context);
     final isFilipino = appState.language == AppLanguage.filipino;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Add spacing
      child: Row(
        children: [
         Text(isFilipino ? "Kulay  " : "Colors"), // Label
          ...[Colors.blue, Colors.yellow, Colors.pink].map(
            (color) => Container(
              margin: const EdgeInsets.only(right: 8), // Space between colors
              height: 30, width: 30, // Circle size
              decoration: BoxDecoration(
                color: color, // Color of the circle
                shape: BoxShape.circle, // Make it circular
                border: Border.all(color: Colors.black), // Black border
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Size Selector Widget
class SizeSelector extends StatelessWidget {
  const SizeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    
     final appState = Provider.of<AppState>(context);
     final isFilipino = appState.language == AppLanguage.filipino;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), // Add spacing
      child: Row(
        children: [
          Text(isFilipino ? "Laki  " : "Size  "), // Label
          ...["S", "M", "L"].map(
            (size) => Padding(
              padding: const EdgeInsets.only(right: 8), // Space between sizes
              child: Chip(label: Text(size)), // Size chip
            ),
          ),
        ],
      ),
    );
  }
}

// Action Buttons Widget
class ActionButtons extends StatelessWidget {
  const ActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    
     final appState = Provider.of<AppState>(context);
     final isFilipino = appState.language == AppLanguage.filipino;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16), // Add spacing
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              onPressed: null, // Disabled for now
              icon: const Icon(Icons.shopping_cart, color: Colors.black), // Cart icon
              label: Text(
              isFilipino ? "IDAGDAG SA CART" : "ADD TO CART",
              style: const TextStyle(color: Colors.black),
            ), // Button text
              style: ElevatedButton.styleFrom(
                disabledBackgroundColor: Color.fromRGBO(251, 248, 204, 1.0), // Explicitly set disabled color
                padding: const EdgeInsets.all(12), // Padding inside button
              ),
            ),
          ),
          const SizedBox(width: 10), // Space between buttons
          Expanded(
            child: ElevatedButton(
              onPressed: null, // Disabled for now
              child: Text(
              isFilipino ? "BILHIN NGAYON" : "BUY NOW",
              style: const TextStyle(color: Colors.white),
            ), // Button text
              style: ElevatedButton.styleFrom(
                disabledBackgroundColor: Color.fromRGBO(240, 112, 152, 1.0), // Explicitly set disabled color
                padding: const EdgeInsets.all(12), // Padding inside button
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Detail Screen
class DetailScreen extends StatelessWidget {
  final Product product; // Product data
  const DetailScreen({required this.product, super.key});

  @override
  Widget build(BuildContext context) {

     final appState = Provider.of<AppState>(context);
     final isFilipino = appState.language == AppLanguage.filipino;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[100], // App bar color
        elevation: 0, // Remove shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black), // Back button
          onPressed: () => Navigator.pop(context), // Go back
        ),
       title: Text(isFilipino ? "Detalye ng Produkto" : "Detail Product",
        style: const TextStyle(color: Colors.black)),
        // Title
        centerTitle: true, // Center title
      ),
      body: Column(
        children: [
          ProductImage(image: product.image), // Show product image
          ProductInfo(product: product), // Show product details
          const CategorySelector(), // Category selector
          const ColorSelector(), // Color selector
          const SizeSelector(), // Size selector
          const ActionButtons(), // Action buttons
        ],
      ),
    );
  }
}

// Main App
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
      home: DetailScreen(
        product: Product(
          name: "Nike Strike+", // Product name
          description: "Men's Water-Repellent Hooded Football Jacket", // Product description
          image: "assets/jacket.png", // Product image path
          price: 4295, // Product price
          rating: 4.9, // Product rating
          reviews: 590, // Number of reviews
        ),
      ),
    );
  }
}
