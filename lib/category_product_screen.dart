import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:productapp_granada2025/product_details.dart';
import 'dart:convert';
import 'config.dart';
import 'product.dart';

class CategoryProductsScreen extends StatefulWidget {
  final int initialCategoryId;
  final String initialCategoryName;

  const CategoryProductsScreen({
    super.key,
    required this.initialCategoryId,
    required this.initialCategoryName,
  });

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  List<Map<String, dynamic>> categories = [];
  List<Map<String, dynamic>> products = [];
  int? selectedCategoryId;
  String? selectedCategoryName;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    selectedCategoryId = widget.initialCategoryId;
    selectedCategoryName = widget.initialCategoryName;
    loadCategoriesAndProducts();
  }

  Future<void> loadCategoriesAndProducts() async {
    setState(() => isLoading = true);
    await loadCategories();
    await loadProductsForCategory(selectedCategoryId!);
    setState(() => isLoading = false);
  }

  Future<void> loadCategories() async {
    final response =
        await http.get(Uri.parse('${AppConfig.baseUrl}/api/categories'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      setState(() {
        categories = data
            .map<Map<String, dynamic>>((item) => {
                  'id': item['id'],
                  'name': item['name'],
                })
            .toList();
      });
    }
  }

  Future<void> loadProductsForCategory(int categoryId) async {
    setState(() => isLoading = true);
    final response = await http.get(
        Uri.parse('${AppConfig.baseUrl}/api/categories/$categoryId/products'));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> raw = jsonData['data'] ?? jsonData;
      setState(() {
        products = List<Map<String, dynamic>>.from(raw);
        selectedCategoryId = categoryId;
        selectedCategoryName =
            categories.firstWhere((c) => c['id'] == categoryId)['name'];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedCategoryName ?? "Category"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                // Category selector
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<int>(
                    value: selectedCategoryId,
                    items: categories
                        .map((cat) => DropdownMenuItem<int>(
                              value: cat['id'],
                              child: Text(cat['name']),
                            ))
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        loadProductsForCategory(value);
                      }
                    },
                  ),
                ),
                // Products list
                Expanded(
                  child: products.isEmpty
                      ? Center(child: Text("No products found."))
                      : ListView.builder(
                          padding: EdgeInsets.all(8),
                          itemCount: products.length,
                          itemBuilder: (context, index) {
                            final product = products[index];
                            final hasImage = product['image_path'] != null &&
                                product['image_path'].toString().isNotEmpty;
                            final imageWidget = hasImage
                                ? Image.network(
                                    '${AppConfig.baseUrl}/storage/${product['image_path']}',
                                    height: 80,
                                    width: 80,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error,
                                            stackTrace) =>
                                        Image.asset(
                                            'assets/product_placeholder.png',
                                            height: 80,
                                            width: 80,
                                            fit: BoxFit.cover),
                                  )
                                : Image.asset('assets/product_placeholder.png',
                                    height: 80, width: 80, fit: BoxFit.cover);
                            return Card(
                              child: ListTile(
                                leading: imageWidget,
                                title: Text(product['name'] ?? '',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(product['description'] ?? '',
                                        style: TextStyle(
                                            fontSize: 12, color: Colors.grey)),
                                    Text(
                                        '₱${product['price']?.toString() ?? ''}',
                                        style: TextStyle(
                                            color: Colors.teal,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ProductDetailsScreen(
                                          product: product),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
    );
  }
}
