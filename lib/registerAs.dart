import 'package:flutter/material.dart';
import 'signup.dart';
import 'signupRetailer.dart';

enum UserType { Farmer, Customer } // Enum for user types

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  UserType _userType = UserType.Farmer; // Default selected user type

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        backgroundColor: Colors.green[700],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildRegistrationCard(),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle user type selection before navigation
                if (_userType == UserType.Farmer) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
                    ),
                  );
                } else {
                  // Handle navigation for customer signup (replace with actual route)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignUpRetailerScreen(),
                    ),
                  );
                }
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Continue'),
                  const SizedBox(width: 8),
                  Icon(Icons.volume_up, color: Colors.white), // Added icon
                ],
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[900],
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildRegistrationCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'How would you like to register?',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.green[700],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Icon(Icons.volume_up, color: Colors.green[700]), // Added icon
              ],
            ),
            const SizedBox(height: 20),
            _buildUserTypeRadio(UserType.Farmer, 'Sell Products'),
            _buildUserTypeRadio(UserType.Customer, 'Buy Products'),
          ],
        ),
      ),
    );
  }

  Widget _buildUserTypeRadio(UserType type, String subtitle) {
    return ListTile(
      title: Text(type.toString().split('.').last), // Get user type name
      subtitle: Text(subtitle),
      leading: Radio<UserType>(
        value: type,
        groupValue: _userType,
        onChanged: (value) => setState(() => _userType = value!),
      ),
      trailing: IconButton(
        icon: Icon(Icons.volume_up,
            color: Colors.green[700]), // Changed icon to speaker
        onPressed: () {
          // Placeholder for voice-to-text functionality
          print('Speaker icon pressed for ${type.toString().split('.').last}');
        },
      ),
    );
  }

  void _handleRegisterButtonPress() {
    String routeName =
        _userType == UserType.Farmer ? '/signup' : '/signupRetailer';
    Navigator.pushNamed(context, routeName);
  }
}
