import 'package:flutter/material.dart'; // Import Flutter material package.

class CategoryButton extends StatelessWidget {
  final String title; // Category name.
  
  const CategoryButton({required this.title, super.key}); // Constructor with required title.

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(title, style: const TextStyle(fontSize: 14)), // Display category title.
      backgroundColor: Colors.orange[100], // Set chip background color.
    );
  }
}
