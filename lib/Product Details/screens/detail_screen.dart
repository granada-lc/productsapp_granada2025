import 'package:flutter/material.dart';  // Flutter UI package
import '../models/product.dart';  // Product model
import '../widgets/product_image.dart';  // Product image widget
import '../widgets/product_info.dart';  // Product info widget
import '../widgets/category_selector.dart';  // Category selector widget
import '../widgets/color_selector.dart';  // Color selector widget
import '../widgets/size_selector.dart';  // Size selector widget
import '../widgets/action_buttons.dart';  // Action buttons widget

class DetailScreen extends StatelessWidget {  // Product detail screen
  final Product product;  // Product data
  const DetailScreen({required this.product, super.key});  // Constructor

  @override
  Widget build(BuildContext context) {  // Build UI
    return Scaffold(
      appBar: AppBar(  // App bar
        backgroundColor: Colors.pink[100],  // Background color
        elevation: 0,  // No shadow
        leading: IconButton(  // Back button
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: null,  // Disabled button
        ),
        title: const Text("Detail Product", style: TextStyle(color: Colors.black)),  // Title
        centerTitle: true,  // Center title
      ),
      body: Column(  // Content layout
        children: [
          ProductImage(image: product.image),  // Product image
          ProductInfo(product: product),  // Product info
          const CategorySelector(),  // Category selector
          const ColorSelector(),  // Color selector
          const SizeSelector(),  // Size selector
          const ActionButtons(),  // Action buttons
        ],
      ),
    );
  }
}
