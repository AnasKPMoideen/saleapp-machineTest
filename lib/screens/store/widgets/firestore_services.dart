import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference storesCollection =
  FirebaseFirestore.instance.collection('store');

  Future<void> addStore(String name, String location) async {
    try {
      await storesCollection.add({
        'Name': name,
        'Location': location,
      });
      log("Store added successfully");
    } catch (e) {
      log("Failed to add store: $e");
    }
  }
}
