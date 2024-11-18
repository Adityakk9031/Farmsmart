// main.dart or home_page.dart
import 'package:farmsmart/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'productList.dart'; // Import the ProductListScreen

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) =>
          ProductProvider(), // Provide the ProductProvider at the top level
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(), // Set the home page
      routes: {
        '/productList': (context) =>
            ProductListScreen(), // Register route for ProductListScreen
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushNamed(
                context, '/productList'); // Navigate to ProductListScreen
          },
          child: Text('Go to Product List'),
        ),
      ),
    );
  }
}
