import 'package:flutter/material.dart'; // Flutter UI package

class ActionButtons extends StatelessWidget {
  // Widget for action buttons
  const ActionButtons({super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    // Build UI
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ), // Add padding around buttons
      child: Row(
        // Arrange buttons in a row
        children: [
          Expanded(
            // Make button expand to fill available space
            child: ElevatedButton.icon(
              // Button with an icon
              onPressed: null, // Disabled button
              icon: const Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ), // Shopping cart icon
              label: const Text(
                "ADD TO CART",
                style: TextStyle(color: Colors.black),
              ), // Button text
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow, // Button background color
                padding: const EdgeInsets.all(12), // Button padding
              ),
            ),
          ),
          const SizedBox(width: 10), // Spacing between buttons
          Expanded(
            // Make button expand to fill available space
            child: ElevatedButton(
              // Regular button
              onPressed: null, // Disabled button
              child: const Text("BUY NOW"), // Button text
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 212, 71, 118), // Button background color
                padding: const EdgeInsets.all(12), // Button padding
              ),
            ),
          ),
        ],
      ),
    );
  }
}
