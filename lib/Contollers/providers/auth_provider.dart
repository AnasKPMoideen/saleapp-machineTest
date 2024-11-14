import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? user;

  Future<void> signInWithPhone(String phoneNumber, Function(String) codeSentCallback) async {
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-signing in the user
        await _firebaseAuth.signInWithCredential(credential);
        user = _firebaseAuth.currentUser;
        notifyListeners();
      },
      verificationFailed: (FirebaseAuthException e) {
        // Handle error (e.g., invalid phone number)
        log("Verification failed: ${e.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        codeSentCallback(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Update the verification ID if timeout occurs
        codeSentCallback(verificationId);
      },
    );
  }

  Future<void> verifyOTP(String verificationId, String smsCode) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );
    try {
      await _firebaseAuth.signInWithCredential(credential);
      user = _firebaseAuth.currentUser;
      notifyListeners();
    } catch (e) {
      log("Error verifying OTP: $e");
    }
  }
}
