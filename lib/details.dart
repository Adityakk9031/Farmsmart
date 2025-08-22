import 'package:farmsmart/bidding.dart';
import 'package:farmsmart/signup.dart';
import 'package:flutter/material.dart';
import 'models.dart'; // Import models.dart which contains the Farmer and Category classes

class DetailScreen extends StatelessWidget {
  final Category category;

  DetailScreen({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${category.name} Farmers'),
      ),
      body: ListView.builder(
        itemCount: category.farmers.length,
        itemBuilder: (context, index) {
          final farmer = category.farmers[index];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SellerScreen()),
              );
            },
            child: ListTile(
              title: Text(farmer.name),
              subtitle: Text('Location: ${farmer.location}'),
              trailing: Text(
                'Rs. 45',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          );
        },
      ),
    );
  }
}
