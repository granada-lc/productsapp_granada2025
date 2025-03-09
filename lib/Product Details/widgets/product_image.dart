import 'package:flutter/material.dart';  // Flutter UI package

class ProductImage extends StatelessWidget {  // Product image widget
  final String image;  // Image path
  const ProductImage({required this.image, super.key});  // Constructor

  @override
  Widget build(BuildContext context) {  // Build UI
    return Container(
      height: 300,  // Set container height
      decoration: BoxDecoration(
        color: Colors.pink[100],  // Background color
        image: DecorationImage(
          image: AssetImage("assets/jacket.png"),  // Load image
          fit: BoxFit.contain,  // Fit image inside
        ),
      ),
    );
  }
}
