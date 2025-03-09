import 'package:flutter/material.dart';  // Flutter UI package

class ColorSelector extends StatelessWidget {  // Color selection widget
  const ColorSelector({super.key});  // Constructor

  @override
  Widget build(BuildContext context) {  // Build UI
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),  // Add padding
      child: Row(  // Arrange items in a row
        children: [
          const Text("Colors  "),  // Label text
          ...[Colors.blue, Colors.yellow, Colors.pink].map(  // List of colors
            (color) => Container(  // Color circle
              margin: const EdgeInsets.only(right: 8),  // Spacing between circles
              height: 30,  // Circle height
              width: 30,  // Circle width
              decoration: BoxDecoration(
                color: color,  // Set color
                shape: BoxShape.circle,  // Circular shape
                border: Border.all(color: Colors.black),  // Black border
              ),
            ),
          ),
        ],
      ),
    );
  }
}
