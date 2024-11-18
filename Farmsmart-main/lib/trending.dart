import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml2json/xml2json.dart';
import 'dart:convert';

class TrendingScreen extends StatefulWidget {
  @override
  _TrendingScreenState createState() => _TrendingScreenState();
}

class _TrendingScreenState extends State<TrendingScreen> {
  final String apiUrl =
      'https://api.data.gov.in/resource/9ef84268-d588-465a-a308-a864a43d0070?api-key=579b464db66ec23bdd0000012c9af70a6ea840ef7231f45b2fe0c329&format=xml&limit=200';
  List<dynamic> mandiData = [];
  List<dynamic> filteredData = [];
  bool isLoading = true;
  String errorMessage = '';
  TextEditingController searchController = TextEditingController();

  // List of predefined products
  final List<String> products = [
    'Rice',
    'Wheat',
    'Pulses',
    'Fruits',
    'Vegetables',
    'Spices',
    'Oils',
    'Dairy Products',
    'Nuts',
    'Herbs'
  ];

  @override
  void initState() {
    super.initState();
    fetchMandiData();
  }

  Future<void> fetchMandiData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final xml2json = Xml2Json();
        xml2json.parse(response.body);
        var jsonData = xml2json.toParker();
        var data = jsonDecode(jsonData);
        setState(() {
          mandiData = data['result']['records']['item'] ?? [];
          filteredData = mandiData;
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage =
              'Failed to load data. Server returned ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'An error occurred: $e';
        isLoading = false;
      });
    }
  }

  void filterSearchResults(String query) {
    List<dynamic> dummySearchList = mandiData;
    if (query.isNotEmpty) {
      List<dynamic> dummyListData = [];
      dummySearchList.forEach((item) {
        if (item['commodity']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            item['state']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase()) ||
            item['market']
                .toString()
                .toLowerCase()
                .contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        filteredData = dummyListData;
      });
      return;
    } else {
      setState(() {
        filteredData = mandiData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trending Mandi Prices',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green[700],
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      filterSearchResults(value);
                    },
                    decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search by commodity, state, or market",
                      prefixIcon: Icon(Icons.search, color: Colors.green),
                      filled: true,
                      fillColor: Colors.grey[200],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                errorMessage.isNotEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            errorMessage,
                            style: TextStyle(color: Colors.red, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : filteredData.isEmpty
                        ? Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                'No data available',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount: filteredData.length,
                              itemBuilder: (context, index) {
                                String titleText = filteredData[index]
                                        ['commodity'] ??
                                    'Unknown';
                                // Check if commodity matches any product in the list
                                for (var product in products) {
                                  if (product.toLowerCase() ==
                                      titleText.toLowerCase()) {
                                    titleText = product;
                                    break;
                                  }
                                }
                                return Card(
                                  elevation: 3,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.all(10),
                                    leading: Icon(Icons.agriculture,
                                        color: Colors.green),
                                    title: Text(
                                      titleText,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'State: ${filteredData[index]['state'] ?? 'N/A'}, Market: ${filteredData[index]['market'] ?? 'N/A'}',
                                          style:
                                              TextStyle(color: Colors.black54),
                                        ),
                                        SizedBox(height: 5),
                                        Text(
                                          'Price: ₹${filteredData[index]['min_price'] ?? 'N/A'} - ₹${filteredData[index]['max_price'] ?? 'N/A'}',
                                          style:
                                              TextStyle(color: Colors.black87),
                                        ),
                                      ],
                                    ),
                                    trailing: Icon(Icons.arrow_forward_ios,
                                        color: Colors.green),
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
