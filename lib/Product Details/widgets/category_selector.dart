import 'package:flutter/material.dart';  // Flutter UI package

class CategorySelector extends StatelessWidget {  // Category selection widget
  const CategorySelector({super.key});  // Constructor

  @override
  Widget build(BuildContext context) {  // Build UI
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),  // Add padding
      child: Row(  // Arrange categories in a row
        children: ["Clothing", "Shoes", "Jewelry"]  // Category list
            .map((category) => Padding(  // Map each category to a Chip
                  padding: const EdgeInsets.only(right: 8),  // Add spacing
                  child: Chip(label: Text(category)),  // Display category as a Chip
                ))
            .toList(),
      ),
    );
  }
}
