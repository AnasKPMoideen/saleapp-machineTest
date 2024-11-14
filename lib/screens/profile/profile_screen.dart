import 'package:flutter/material.dart';
import 'package:saleapp/Order/order_history_screen.dart';
import 'package:saleapp/screens/Products/product_list_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Products/widgets/add_product_screen.dart';
import '../store/store_list_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userName = "Username";
  String _mobileNumber = "Mobile Number";
  String _email = "Email";

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('user_name') ?? "Username";
      _mobileNumber = prefs.getString('mobile_number') ?? "Mobile Number";
      _email = prefs.getString('user_email') ?? "Email";
    });
  }

  void _onOptionSelected(String option) {
    switch (option) {
      case 'Account Management':
        break;
      case 'Stores':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => StoreListScreen()),
        );
        break;
      case 'Products':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProductListScreen()),
        );
        break;
      case 'Add Products':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AddProductScreen()),
        );
        break;
        case 'Order History':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OrderHistoryScreen()),
        );
        break;
      case 'Logout':
        _logout();
        break;
    }
  }

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _userName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              _mobileNumber,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            Text(
              _email,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: ListView(
                children: [
                  _buildOptionTile(context, 'Stores'),
                  _buildOptionTile(context, 'Products'),
                  _buildOptionTile(context, 'Add Products'),
                  _buildOptionTile(context, 'Order History'),
                  _buildOptionTile(context, 'Account Management'),
                  _buildOptionTile(context, 'Logout'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(BuildContext context, String title) {
    return ListTile(
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () => _onOptionSelected(title),
    );
  }
}
