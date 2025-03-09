import 'package:flutter/material.dart';
import 'screens/detail_screen.dart';
import 'models/product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DetailScreen(
        product: Product(
          name: "Nike Strike+",
          description: "Men's Water-Repellent Hooded Football Jacket",
          image: "assets/jacket.png",
          price: 4295,
          rating: 4.9,
          reviews: 590,
        ),
      ),
    );
  }
}
