import 'package:flutter/material.dart';

class SellerScreen extends StatefulWidget {
  @override
  _SellerScreenState createState() => _SellerScreenState();
}

class _SellerScreenState extends State<SellerScreen> {
  // Data structure to hold the seller's crops and vegetables with bids from multiple farmers
  Map<String, dynamic> seller = {
    'name': 'Seller A',
    'items': [
      {
        'type': 'Crop',
        'name': 'Wheat',
        'quantity': 100,
        'listedPrice': 60,
        'bids': [
          {'farmer': 'Farmer 1', 'bidAmount': 55},
          {'farmer': 'Farmer 2', 'bidAmount': 58},
          {'farmer': 'Farmer 3', 'bidAmount': 53},
        ],
        'acceptedBid': null, // Holds the accepted bid for this item
      },
      {
        'type': 'Vegetable',
        'name': 'Tomato',
        'quantity': 200,
        'listedPrice': 40,
        'bids': [
          {'farmer': 'Farmer 4', 'bidAmount': 38},
          {'farmer': 'Farmer 5', 'bidAmount': 39},
        ],
        'acceptedBid': null, // Holds the accepted bid for this item
      },
    ],
  };

  final TextEditingController _bidController =
      TextEditingController(); // Controller for the bid input

  void acceptBid(int itemIndex, int bidIndex) {
    setState(() {
      // Create a deep copy of the accepted bid to avoid reference issues
      seller['items'][itemIndex]['acceptedBid'] = Map<String, dynamic>.from(
          seller['items'][itemIndex]['bids'][bidIndex]);

      // Remove other bids and keep only the accepted one
      seller['items'][itemIndex]
          ['bids'] = [seller['items'][itemIndex]['acceptedBid']];
    });
  }

  void rejectBid(int itemIndex, int bidIndex) {
    setState(() {
      seller['items'][itemIndex]['bids'].removeAt(bidIndex);
    });
  }

  void updateBidPrice(int itemIndex) {
    if (_bidController.text.isNotEmpty &&
        int.tryParse(_bidController.text) != null) {
      setState(() {
        // Ensure we're updating only the accepted bid's price
        if (seller['items'][itemIndex]['acceptedBid'] != null) {
          seller['items'][itemIndex]['acceptedBid'] = {
            ...seller['items'][itemIndex]['acceptedBid'],
            'bidAmount': int.parse(_bidController.text),
          };

          // Update the bids list to reflect the new accepted bid price
          seller['items'][itemIndex]['bids'][0] =
              seller['items'][itemIndex]['acceptedBid'];
        }
      });
    }
  }

  @override
  void dispose() {
    _bidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seller\'s Listings'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${seller['name']}\'s Listings',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[900],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: seller['items'].length,
                itemBuilder: (context, itemIndex) {
                  var item = seller['items'][itemIndex];
                  return Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${item['type']}: ${item['name']}',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Quantity: ${item['quantity']} kg',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                          Text(
                            'Listed Price: \$${item['listedPrice']}',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[700],
                            ),
                          ),
                          SizedBox(height: 10),
                          if (item['acceptedBid'] == null) ...[
                            Text(
                              'Bids:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey[800],
                              ),
                            ),
                            SizedBox(height: 5),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: item['bids'].length,
                              itemBuilder: (context, bidIndex) {
                                return ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 4),
                                  title: Text(
                                    '${item['bids'][bidIndex]['farmer']}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent,
                                    ),
                                  ),
                                  subtitle: Text(
                                    'Bid Amount: \$${item['bids'][bidIndex]['bidAmount']}',
                                    style: TextStyle(color: Colors.grey[700]),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          acceptBid(itemIndex, bidIndex);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: Text('Accept'),
                                      ),
                                      SizedBox(width: 10),
                                      ElevatedButton(
                                        onPressed: () {
                                          rejectBid(itemIndex, bidIndex);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: Text('Reject'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ] else ...[
                            SizedBox(height: 10),
                            Text(
                              'Negotiation with ${item['acceptedBid']['farmer']}:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueGrey[800],
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Current Bid Amount: \$${item['acceptedBid']['bidAmount']}',
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            SizedBox(height: 10),
                            TextField(
                              controller: _bidController,
                              decoration: InputDecoration(
                                labelText: 'Enter your new bid price',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.number,
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                updateBidPrice(itemIndex);
                                _bidController
                                    .clear(); // Clear the input field after updating
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blueAccent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: Text('Update Bid Price'),
                            ),
                          ]
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
