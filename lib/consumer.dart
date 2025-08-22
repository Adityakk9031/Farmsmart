import 'package:flutter/material.dart';
import 'details.dart';
import 'models.dart'; // Import models.dart which contains the Farmer and Category classes

class ConsumerScreen extends StatelessWidget {
  final List<Category> categories = [
    Category(name: 'Wheat', farmers: [
      Farmer(name: 'Ram Kishan', location: 'Noida', products: ['Wheat']),
      Farmer(name: 'Jaya Kishori', location: 'Bareily', products: ['Wheat']),
    ]),
    Category(name: 'Rice', farmers: [
      Farmer(name: 'Hari Sharma', location: 'Haryana', products: ['Rice']),
      Farmer(name: 'Keshav Rana', location: 'Haryana', products: ['Rice']),
    ]),
    Category(name: 'Fruits', farmers: [
      Farmer(name: 'Amit Singh', location: 'Delhi', products: ['Fruits']),
      Farmer(name: 'Sita Devi', location: 'Maharashtra', products: ['Fruits']),
    ]),
    Category(name: 'Vegetables', farmers: [
      Farmer(name: 'Ravi Kumar', location: 'Punjab', products: ['Vegetables']),
      Farmer(
          name: 'Geeta Rani',
          location: 'Uttar Pradesh',
          products: ['Vegetables']),
    ]),
    Category(name: 'Seeds', farmers: [
      Farmer(name: 'Ajay Patel', location: 'Gujarat', products: ['Seeds']),
      Farmer(name: 'Sunita Yadav', location: 'Rajasthan', products: ['Seeds']),
    ]),
    Category(name: 'Spices', farmers: [
      Farmer(name: 'Deepak Sharma', location: 'Kerala', products: ['Spices']),
      Farmer(
          name: 'Anita Sinha', location: 'West Bengal', products: ['Spices']),
    ]),
    // Add more categories and farmers as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Categories'),
      ),
      body: Container(
        color: Colors.green[200], // Set background color here
        child: GridView.builder(
          padding: EdgeInsets.all(8.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(category: category),
                  ),
                );
              },
              child: Card(
                color: _getColorForCategory(category.name),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      category.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                        height: 8), // Add some spacing between text and button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailScreen(category: category),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Colors.white, // Button background color
                        foregroundColor: Colors.black, // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text('Details'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Color _getColorForCategory(String categoryName) {
    switch (categoryName) {
      case 'Wheat':
        return Color.fromARGB(255, 9, 119, 24);
      case 'Rice':
        return Color.fromARGB(255, 175, 22, 88);
      case 'Fruits':
        return Colors.red;
      case 'Vegetables':
        return Color.fromARGB(255, 61, 39, 151);
      case 'Seeds':
        return Colors.brown;
      case 'Spices':
        return Color.fromARGB(255, 215, 42, 134);
      default:
        return Colors.grey;
    }
  }
}
