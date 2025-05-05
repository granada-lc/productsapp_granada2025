import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({super.key});

  @override
  _CreateProductScreenState createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  String _selectedCategory = 'Shoes'; // default key
  final List<String> _categories = ['Shoes', 'Clothing', 'Accessories'];

  String _getLocalizedCategory(String key, bool isFilipino) {
    final map = {
      'Shoes': isFilipino ? 'Sapatos' : 'Shoes',
      'Clothing': isFilipino ? 'Damit' : 'Clothing',
      'Accessories': isFilipino ? 'Mga Accessorya' : 'Accessories',
    };
    return map[key] ?? key;
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final isFilipino = appState.language == AppLanguage.filipino;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        title: Text(
          isFilipino ? "Lumikha ng Bagong Produkto" : "Create New Product",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(isFilipino ? "Pangalan ng Produkto" : "Product Name",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: isFilipino ? "Ilagay ang pangalan ng produkto" : "Enter product name",
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 15),

            Text(isFilipino ? "Presyo" : "Price",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            TextField(
              controller: _priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                prefixText: "₱",
                border: const OutlineInputBorder(),
                hintText: isFilipino ? "Ilagay ang presyo" : "Enter price",
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 15),

            Text(isFilipino ? "Kategorya" : "Category",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black45),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: DropdownButton<String>(
                value: _selectedCategory,
                isExpanded: true,
                underline: const SizedBox(),
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(_getLocalizedCategory(category, isFilipino)),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue!;
                  });
                },
              ),
            ),
            const SizedBox(height: 15),

            Text(isFilipino ? "Paglalarawan" : "Description",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: isFilipino ? "Ilagay ang paglalarawan ng produkto..." : "Product Description here ...",
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow[600],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      isFilipino ? "KANSELA" : "CANCEL",
                      style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle save logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    child: Text(
                      isFilipino ? "ISAVE" : "SAVE",
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
