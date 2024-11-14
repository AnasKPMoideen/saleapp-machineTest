import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../widgets/Common_App_bar.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController taxPercentageController = TextEditingController();

  Future<void> _addProduct() async {
    final productName = nameController.text.trim();
    final productPrice = double.tryParse(priceController.text.trim()) ?? 0.0;
    final taxPercentage = double.tryParse(taxPercentageController.text.trim()) ?? 0.0;

    if (productName.isEmpty || productPrice <= 0.0 || taxPercentage < 0.0) {
      // Show error message if any field is invalid
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields correctly'),
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    // Store product in Firestore
    await FirebaseFirestore.instance.collection('products').add({
      'product_name': productName,
      'price': productPrice,
      'tax_percentage': taxPercentage,
      'created_at': FieldValue.serverTimestamp(),
    });

    // Clear the input fields
    nameController.clear();
    priceController.clear();
    taxPercentageController.clear();

    // Show success message and navigate back
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Product successfully added'),
        duration: Duration(seconds: 2),
      ),
    );

    Navigator.pop(context); // Go back to the profile screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Add Product'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Product Name',
                border: OutlineInputBorder(  // Add 4-side border to the phone number field
                  borderRadius: BorderRadius.circular(8),
                ),),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Price',
                border: OutlineInputBorder(  // Add 4-side border to the phone number field
                  borderRadius: BorderRadius.circular(8),
                ),),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: taxPercentageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Tax Percentage',
                  border: OutlineInputBorder(  // Add 4-side border to the phone number field
                  borderRadius: BorderRadius.circular(8),
            ),),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addProduct,
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Rounded corners for the button
                ),
              ),
              child: const Text('Add Product'),
            ),
          ],
        ),
      ),
    );
  }
}
