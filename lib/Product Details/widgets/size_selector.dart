import 'package:flutter/material.dart';  // Flutter UI package

class SizeSelector extends StatelessWidget {  // Size selection widget
  const SizeSelector({super.key});  // Constructor

  @override
  Widget build(BuildContext context) {  // Build UI
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),  // Add padding
      child: Row(  // Arrange items in a row
        children: [
          const Text("Size  "),  // Label text
          ...["S", "M", "L"].map(  // List of sizes
            (size) => Padding(
              padding: const EdgeInsets.only(right: 8),  // Spacing
              child: Chip(label: Text(size)),  // Display size as a Chip
            ),
          ),
        ],
      ),
    );
  }
}
