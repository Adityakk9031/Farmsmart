import 'package:farmsmart/consumer.dart';
import 'package:farmsmart/post.dart';
import 'package:farmsmart/productList.dart';
import 'package:farmsmart/profile.dart';
import 'package:farmsmart/trending.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FarmerHome extends StatelessWidget {
  const FarmerHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 149, 242, 154),
        title: const Text(
          'FarmSmart',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 40.0),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 15,
                    offset: Offset(0, 10), // Shadow position
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image.asset(
                  'assets/image/homefarmer.jpg',
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 70.0), // Adjust as needed
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TrendingScreen()),
                      );
                    },
                    child: buildIconButtonWithShadow(
                        Icons.trending_up, 'Trending Rates'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetailScreen()),
                      );
                    },
                    child: buildIconButtonWithShadow(Icons.add, 'Post Item'),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductListScreen()),
                      );
                    },
                    child:
                        buildIconButtonWithShadow(Icons.list, 'Products List'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(
            left: 7, right: 7, bottom: 20.0), // Adjust margin as needed
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 149, 242, 154),
          borderRadius: BorderRadius.all(Radius.circular(30)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Shadow color
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 5), // Shadow offset
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: 50.0), // Adjust padding as needed
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.home, size: 35),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FarmerHome()));
                },
              ),
              IconButton(
                icon: const Icon(Icons.person, size: 35),
                onPressed: () {
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
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 4, 116, 7),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductDetailScreen()),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 40,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Column buildIconButtonWithShadow(IconData icon, String text) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle, // Ensure the shadow is circular
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3), // Lighter shadow color
                spreadRadius: 1,
                blurRadius: 8,
                offset: Offset(0, 9), // Slight offset
              ),
            ],
          ),
          child: CircleAvatar(
            backgroundColor: Color.fromARGB(255, 149, 242, 154),
            radius: 30,
            child: Icon(
              icon,
              color: Colors.pink[800],
              size: 50,
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          text,
          style: const TextStyle(
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
