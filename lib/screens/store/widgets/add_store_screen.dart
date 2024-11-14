import 'package:flutter/material.dart';
import 'firestore_services.dart';

class AddStoreScreen extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();

  void _addStore(BuildContext context) {
    final name = nameController.text.trim();
    final location = locationController.text.trim();
    if (name.isEmpty || location.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    firestoreService.addStore(name, location).then((_) {
      nameController.clear();
      locationController.clear();
      Navigator.pushNamed(context, '/home').then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Store successfully added'),
            duration: Duration(seconds: 2),
          ),
        );
      });
    }).catchError((error) {
      Navigator.pushNamed(context, '/home').then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to add store: $error'),
            duration: const Duration(seconds: 2),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Store'),
      automaticallyImplyLeading: false,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Store Name',
                border: OutlineInputBorder(  // Add 4-side border to the phone number field
                  borderRadius: BorderRadius.circular(8),
                ),),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: locationController,
              decoration: InputDecoration(labelText: 'Location',
                border: OutlineInputBorder(  // Add 4-side border to the phone number field
                  borderRadius: BorderRadius.circular(8),
                ),),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () => _addStore(context),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Add Store'),
            ),
          ],
        ),
      ),
    );
  }
}
