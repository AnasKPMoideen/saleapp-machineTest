import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StoreProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addStore(String userId, String storeName, String location) async {
    await _firestore.collection("stores").doc(userId).set({
      "storeName": storeName,
      "location": location,
    });
    notifyListeners();
  }
}
