import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfoScreen extends StatefulWidget {
  final String phoneNumber;

  UserInfoScreen({required this.phoneNumber});

  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isSubmitButtonEnabled = false;
  String? _emailErrorMessage;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    String? mobileNumber = prefs.getString('mobile_number');
    if (mobileNumber != null) {
      setState(() {
        _isSubmitButtonEnabled = false;
      });
    }
  }

  bool _isEmailValid(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  void _validateFields() {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();

    setState(() {
      _isSubmitButtonEnabled = name.isNotEmpty && email.isNotEmpty && _isEmailValid(email);
    });
  }

  // Validate email on change
  void _validateEmail(String email) {
    setState(() {
      if (_isEmailValid(email)) {
        _emailErrorMessage = null;
      } else {
        _emailErrorMessage = "Please enter a valid email";
      }
      _validateFields();
    });
  }

  Future<void> _submitForm() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();

    if (_isSubmitButtonEnabled) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_name', name);
      await prefs.setString('user_email', email);
      await prefs.setString('user_mobile', widget.phoneNumber);

      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields correctly.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back_ios)),
          title: const Text("Enter Your Details")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name input
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Name",
                border: OutlineInputBorder(  // Add 4-side border to the phone number field
                  borderRadius: BorderRadius.circular(8),
                ),),
              onChanged: (_) => _validateFields(),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _emailController,
              decoration:  InputDecoration(labelText: "Email",
                border: OutlineInputBorder(  // Add 4-side border to the phone number field
                  borderRadius: BorderRadius.circular(8),
                ),),
              keyboardType: TextInputType.emailAddress,
              onChanged: _validateEmail,
            ),
            if (_emailErrorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  _emailErrorMessage!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
            const SizedBox(height: 15),
            TextField(
              controller: TextEditingController(text: widget.phoneNumber),
              decoration: InputDecoration(labelText: "Mobile Number",
                border: OutlineInputBorder(  // Add 4-side border to the phone number field
                  borderRadius: BorderRadius.circular(8),
                ),),
              readOnly: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isSubmitButtonEnabled ? _submitForm : null,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Rounded corners for the button
                ),
              ),
              child: const Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
