import 'dart:math';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'login_screen.dart';
import 'myproduct_screen.dart';
import 'product_details.dart';
import 'config.dart';
import 'product.dart'; // Ensure this imports your Product model
import 'create_product_screen.dart';
import 'user_preference.dart';
import 'editproduct_screen.dart';
import 'app_state.dart';
import 'package:productapp_granada2025/models/Products.dart' as ModelProducts;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> allProducts = [];
  List<Map<String, dynamic>> categories = [];
  bool isLoading = true;
  String? userName;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    loadProducts();
    loadCategories();
    loadUserInfo();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showWelcomeDialog();
    });
  }

  void showWelcomeDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Welcome!"),
        content: Text("You have successfully logged in."),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  Future<void> loadProducts() async {
    try {
      final response =
          await http.get(Uri.parse('${AppConfig.baseUrl}/api/products?all=1'));
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final raw = jsonData['data'] ?? jsonData;
        setState(() {
          allProducts =
              List<Product>.from(raw.map((item) => Product.fromJson(item)));
          isLoading = false;
        });
      }
    } catch (e) {
      print('Failed to load products: $e');
      setState(() => isLoading = false);
    }
  }

  Future<void> loadCategories() async {
    try {
      final response =
          await http.get(Uri.parse('${AppConfig.baseUrl}/api/categories'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          categories = data
              .map<Map<String, dynamic>>((item) => {
                    'id': item['id'],
                    'name': item['name'],
                    'image_path': item['image_path'],
                  })
              .toList();
        });
      }
    } catch (e) {
      print('Failed to load categories: $e');
    }
  }

  Future<void> loadUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name') ?? 'User Name';
      userEmail = prefs.getString('user_email') ?? 'user@example.com';
    });
  }

  Widget categoryButton(String title) {
    return Chip(
      label: Text(title, style: const TextStyle(fontSize: 14)),
      backgroundColor: Colors.orange[100],
    );
  }

  Widget productCard(Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductInfo(product: product),
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
                  image: NetworkImage(
                      '${AppConfig.baseUrl}/storage/${product.imagePath}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(product.name,
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(product.description,
              style: const TextStyle(fontSize: 12, color: Colors.grey)),
          Text("₱${product.price}",
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isFilipino = appState.language == AppLanguage.filipino;
    final backgroundColor =
        getThemeData(appState.theme).appBarTheme.backgroundColor;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: backgroundColor,
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
              decoration: BoxDecoration(color: backgroundColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                      backgroundImage: AssetImage("assets/profile.jpg"),
                      radius: 30),
                  SizedBox(height: 10),
                  Text(userName ?? "User Name",
                      style: TextStyle(fontSize: 18, color: Colors.white)),
                  Text(userEmail ?? "user@example.com",
                      style: TextStyle(fontSize: 14, color: Colors.white70)),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: Text(isFilipino
                  ? "Lumikha ng Bagong Produkto"
                  : "Create New Product"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => CreateProductScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.inventory),
              title: Text(isFilipino ? "Iyong Mga Produkto" : 'My Products'),
              onTap: () async {
                Navigator.pop(context);
                final prefs = await SharedPreferences.getInstance();
                final userId = prefs.getInt('user_id');
                if (userId != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => MyProductsScreen(userId: userId)));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(isFilipino
                          ? "Walang naka-log in na user."
                          : "No user logged in.")));
                }
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(isFilipino
                  ? "Mga Kagustuhan ng Gumagamit"
                  : "User Preferences"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => UserPreferencesScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(isFilipino ? "Mag Logout" : "Logout"),
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => LoginScreen()));
              },
            ),
          ],
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: categories
                        .map((cat) => categoryButton(cat['name']))
                        .toList(),
                  ),
                  const SizedBox(height: 20),
                  Text(isFilipino ? "Pinaka Sikat" : "Most Popular",
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Expanded(
                    child: GridView.builder(
                      itemCount: allProducts.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemBuilder: (context, index) {
                        return productCard(allProducts[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
