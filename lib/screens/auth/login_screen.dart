import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Contollers/providers/auth_provider.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final String _verificationId = '';

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
          title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Phone Number Field
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                prefixText: '+91 ', // Add the country code as a prefix
                labelText: "Phone Number",
                border: OutlineInputBorder(  // Add 4-side border to the phone number field
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 25),
            // Send OTP Button
            ElevatedButton(
              onPressed: () async {
                final phone = _phoneController.text.trim();
                if (phone.isEmpty || phone.length != 10) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a valid 10-digit phone number.')),
                  );
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VerifyOtpScreen(phoneNumber: '+91$phone'), // Send full phone number
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Rounded corners for the button
                ),
              ),
              child: const Text("Send OTP"),
            ),
            if (_verificationId.isNotEmpty) ...[
              // OTP Field
              TextField(
                controller: _otpController,
                decoration: const InputDecoration(labelText: "Enter OTP"),
              ),
              const SizedBox(height: 25),
              // Verify OTP Button
              ElevatedButton(
                onPressed: () async {
                  await authProvider.verifyOTP(_verificationId, _otpController.text);
                  if (authProvider.user != null) {
                    Navigator.pushReplacementNamed(context, "/store");
                  }
                },
                child: const Text("Verify OTP"),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
