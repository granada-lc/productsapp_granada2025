import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'product_details.dart';
import 'product.dart';
import 'create_product_screen.dart';
import 'user_preference.dart';
import 'login_screen.dart';
import 'app_state.dart';

// Category Button Widget
class CategoryButton extends StatelessWidget {
  final String title;
  const CategoryButton({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(title, style: const TextStyle(fontSize: 14)),
      backgroundColor: Colors.orange[100],
    );
  }
}

// Product Card Widget
class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(product: product),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.yellow[100],
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: AssetImage(product.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(product.description, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          Text("₱${product.price}", style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

// Home Screen
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isFilipino = appState.language == AppLanguage.filipino;

    final drawerTitle = isFilipino ? "Menu" : "Menu";
    final createProduct = isFilipino ? "Lumikha ng Bagong Produkto" : "Create New Product";
    final preferences = isFilipino ? "Mga Kagustuhan ng Gumagamit" : "User Preferences";
     final logout = isFilipino ? "Mag Logout" : "Logout";
    final mostPopular = isFilipino ? "Pinaka Sikat" : "Most Popular";

    final categories = isFilipino
        ? ["Dyaket", "Bag", "Kamisa", "Sumbrero"]
        : ["Jacket", "Bags", "Shirt", "Hat"];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(244, 194, 194, 1.0),
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
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
        child: Text(
          drawerTitle,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      ListTile(
        leading: const Icon(Icons.add),
        title: Text(createProduct),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CreateProductScreen()),
          );
        },
      ),
      ListTile(
        leading: const Icon(Icons.settings),
        title: Text(preferences),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const UserPreferencesScreen()),
          );
        },
      ),
      ListTile(
        leading: const Icon(Icons.logout),
        title: Text(logout),
        onTap: () {
          // Add your logout logic here (if any, like clearing user session)
          
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
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
              children: categories.map((title) => CategoryButton(title: title)).toList(),
            ),
            const SizedBox(height: 20),
            Text(mostPopular, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
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
  }
}
