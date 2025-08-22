import 'package:farmsmart/farmerHome.dart';
import 'package:flutter/material.dart';

class FarmerProfileScreen extends StatelessWidget {
  const FarmerProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Farmer Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Replace with actual image
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/farmer.png'),
            ),
            SizedBox(height: 16),
            Text(
              'Hari Om',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Phone: 1234567890'),
            SizedBox(height: 8),
            Text('Area: Rural'),
            SizedBox(height: 8),
            Text('City: Greater Noida'),
            SizedBox(height: 8),
            Text('State: Uttar Pradesh'),
          ],
        ),
      ),
      // Adding the bottom navigation bar here
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 50.0,
        ), // Adjust padding as needed
        height: 60,
        margin: const EdgeInsets.only(bottom: 20.0, left: 7, right: 7),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 149, 242, 154),
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.home, size: 35),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FarmerHome()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.person, size: 35),
              onPressed: () {
                // Keeping the current profile screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FarmerProfileScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
