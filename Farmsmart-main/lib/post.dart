import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';

// Remove the main function and MyApp class
// These are not needed in a normal page file

class Product {
  final String name;
  final String price;
  final String description;
  final String category;
  final File image;

  Product({
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
  });
}

class ProductProvider with ChangeNotifier {
  List<Product> _products = [];

  List<Product> get products => _products;

  void addProduct(Product product) {
    _products.add(product);
    notifyListeners();
  }
}

class ProductDetailScreen extends StatefulWidget {
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  void _uploadProduct(BuildContext context) {
    final String name = _nameController.text;
    final String price = _priceController.text;
    final String description = _descriptionController.text;
    final String category = _categoryController.text;

    if (name.isNotEmpty &&
        price.isNotEmpty &&
        description.isNotEmpty &&
        category.isNotEmpty &&
        _image != null) {
      final product = Product(
        name: name,
        price: price,
        description: description,
        category: category,
        image: _image!,
      );

      Provider.of<ProductProvider>(context, listen: false).addProduct(product);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Product uploaded successfully!'),
        ),
      );

      // Clear the form fields after uploading
      _nameController.clear();
      _priceController.clear();
      _descriptionController.clear();
      _categoryController.clear();
      setState(() {
        _image = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill all fields and upload an image.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FarmSmart'),
        backgroundColor: Colors.lightGreenAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              _image == null
                  ? Icon(
                      Icons.agriculture,
                      size: 100,
                      color: Colors.green,
                    )
                  : Image.file(_image!, height: 100),
              SizedBox(height: 20),
              TextButton(
                onPressed: _pickImage,
                child: Column(
                  children: [
                    Icon(Icons.upload_file, size: 50, color: Colors.black),
                    Text('UPLOAD THE IMAGE OF THE PRODUCT'),
                  ],
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'NAME',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(
                  labelText: 'PRICE',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'DESCRIPTION',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _categoryController,
                decoration: InputDecoration(
                  labelText: 'CATEGORY',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _uploadProduct(context),
                child: Text('Upload Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
