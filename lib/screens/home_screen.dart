import 'package:flutter/material.dart';
import '../widgets/category_button.dart'; // Import custom category button widget.
import '../widgets/product_card.dart'; // Import custom product card widget.
import '../data/dummy_products.dart'; // Import product data.

// Home screen of the app.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[100], // Set app bar background color.
        elevation: 0, // Remove shadow.
        leading: const Icon(Icons.menu, color: Colors.black), // Menu icon.
        actions: const [
          Icon(Icons.notifications_none, color: Colors.black), // Notification icon.
          SizedBox(width: 16), // Spacing.
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding around content.
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start.
          children: [
            // Category Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space buttons evenly.
              children: ["Jacket", "Bags", "Shirt", "Hat"]
                  .map((category) => CategoryButton(title: category)) // Generate buttons dynamically.
                  .toList(),
            ),
            const SizedBox(height: 20), // Add vertical spacing.
            const Text(
              "Most Popular",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Heading style.
            ),
            const SizedBox(height: 10), // Add spacing.

            // Product Grid
            Expanded(
              child: GridView.builder(
                itemCount: products.length, // Total number of products.
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Display two items per row.
                  childAspectRatio: 0.7, // Aspect ratio of grid items.
                  crossAxisSpacing: 12, // Horizontal spacing.
                  mainAxisSpacing: 12, // Vertical spacing.
                ),
                itemBuilder: (context, index) {
                  final product = products[index]; // Get product data.
                  return ProductCard(product: product); // Display product card.
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
