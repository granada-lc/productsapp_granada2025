import 'package:flutter/material.dart';
import 'product_details.dart';
import 'product.dart';
import 'create_product_screen.dart';

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
}class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(244, 194, 194, 1.0),
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(), // Open Drawer
          ),
        ),
        actions: const [
          Icon(Icons.notifications_none, color: Colors.black),
          SizedBox(width: 16),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.pink[100]),
              child: const Text(
                'Menu',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('Create New Product'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CreateProductScreen()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('User Preferences'),
              onTap: () {
                // Implement User Preferences Navigation
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ["Jacket", "Bags", "Shirt", "Hat"]
                  .map((category) => CategoryButton(title: category))
                  .toList(),
            ),
            const SizedBox(height: 20),
            const Text("Most Popular", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (context, index) {
                  return ProductCard(product: products[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }}