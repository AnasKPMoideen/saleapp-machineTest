import 'dart:developer';
import 'package:flutter/material.dart';
import '../../widgets/Common_App_bar.dart';
import '../profile/widgets/add_prifile_screen.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String phoneNumber;

  VerifyOtpScreen({required this.phoneNumber});

  @override
  _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Verify Otp'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              "A verification code has been sent to ${widget.phoneNumber}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _otpController,
              decoration: InputDecoration(labelText: "Enter OTP",
                border: OutlineInputBorder(  // Add 4-side border to the phone number field
                  borderRadius: BorderRadius.circular(8),
                ),),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                final otp = _otpController.text.trim();
                if (otp.isEmpty || otp.length != 6) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a valid 6-digit OTP.')),
                  );
                  return;
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('OTP Verified Successfully!')),
                );
                log(widget.phoneNumber, name: 'phone number');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserInfoScreen(phoneNumber: widget.phoneNumber),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Rounded corners for the button
                ),
              ),
              child: const Text("Verify OTP"),
            ),
          ],
        ),
      ),
    );
  }
}
