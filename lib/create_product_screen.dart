import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'category_service.dart';
import 'config.dart';
import 'app_state.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  State<CreateProductScreen> createState() => _CreateProductScreenState();
}

class AddProductService {
  static Future<bool> addProduct({
    required String name,
    required String description,
    required String price,
    required int categoryId,
    required int userId,
    File? image,
  }) async {
    final url = Uri.parse('${AppConfig.baseUrl}/api/products');
    var request = http.MultipartRequest('POST', url);
    request.fields['name'] = name;
    request.fields['description'] = description;
    request.fields['price'] = price;
    request.fields['category_id'] = categoryId.toString();
    request.fields['user_id'] = userId.toString();

    if (image != null) {
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
    }

    final response = await request.send();
    return response.statusCode == 201;
  }
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  File? _selectedImage;
  List<Map<String, dynamic>> _categories = [];
  String? _selectedCategoryId;
  bool _loadingCategories = true;

  Future<void> _loadCategories() async {
    try {
      final categories = await CategoryService.getCategories();
      setState(() {
        _categories = categories;
        _selectedCategoryId = categories.isNotEmpty
            ? categories.first['id'].toString()
            : null;
      });
    } catch (e) {
      // Handle error here
    } finally {
      setState(() => _loadingCategories = false);
    }
  }

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _selectedImage = File(picked.path);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isFilipino = appState.language == AppLanguage.filipino;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text(
          isFilipino ? "Lumikha ng Bagong Produkto" : "Create New Product",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _loadingCategories
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  Text(
                    isFilipino ? "Larawan ng Produkto" : "Product Image",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: _pickImage,
                    child: _selectedImage == null
                        ? Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(Icons.add_a_photo, size: 40),
                          )
                        : Image.file(
                            _selectedImage!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                  ),
                  const SizedBox(height: 20),
                  _buildLabeledField(
                    isFilipino ? "Pangalan ng Produkto" : "Product Name",
                    _nameController,
                    isFilipino ? "Ilagay ang pangalan ng produkto" : "Enter product name",
                  ),
                  const SizedBox(height: 15),
                  _buildLabeledField(
                    isFilipino ? "Presyo" : "Price",
                    _priceController,
                    isFilipino ? "Ilagay ang presyo" : "Enter price",
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    isFilipino ? "Kategorya" : "Category",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  DropdownButtonFormField<String>(
                    value: _selectedCategoryId,
                    isExpanded: true,
                    decoration: const InputDecoration(border: OutlineInputBorder()),
                    items: _categories.map((cat) {
                      return DropdownMenuItem<String>(
                        value: cat['id'].toString(),
                        child: Text(cat['name']),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategoryId = value;
                      });
                    },
                  ),
                  const SizedBox(height: 15),
                  _buildLabeledField(
                    isFilipino ? "Paglalarawan" : "Description",
                    _descriptionController,
                    isFilipino
                        ? "Ilagay ang paglalarawan ng produkto..."
                        : "Enter product description...",
                    maxLines: 4,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow[700],
                          ),
                          child: Text(isFilipino ? "KANSELA" : "CANCEL"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _submitProduct,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink,
                          ),
                          child: Text(isFilipino ? "ISAVE" : "SAVE"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildLabeledField(String label, TextEditingController controller, String hint,
      {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Future<void> _submitProduct() async {
    final appState = Provider.of<AppState>(context, listen: false);
    final isFilipino = appState.language == AppLanguage.filipino;

    if (_nameController.text.isEmpty ||
        _priceController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _selectedCategoryId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              isFilipino ? "Pakitapos ang lahat ng fields." : "Please complete all fields."),
        ),
      );
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');

    if (userId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not logged in.")),
      );
      return;
    }

    try {
      final success = await AddProductService.addProduct(
        name: _nameController.text,
        description: _descriptionController.text,
        price: _priceController.text,
        categoryId: int.parse(_selectedCategoryId!),
        userId: userId,
        image: _selectedImage,
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(isFilipino
                  ? "Matagumpay na naidagdag ang produkto!"
                  : "Product added successfully!")),
        );
        Navigator.pop(context);
      } else {
        throw Exception("Server error");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(isFilipino
                ? "Nabigo ang pagdaragdag ng produkto."
                : "Failed to add product.")),
      );
    }
  }
}
