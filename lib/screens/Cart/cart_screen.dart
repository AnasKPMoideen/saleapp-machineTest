import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widgets/Common_App_bar.dart';

class CartScreen extends StatelessWidget {
  final List<Map<String, dynamic>> cart; // List of products in the cart

  const CartScreen({Key? key, required this.cart}) : super(key: key);

  Future<void> _checkout(BuildContext context) async {
    try {
      CollectionReference orders = FirebaseFirestore.instance.collection('orders');

      List<Map<String, dynamic>> orderItems = cart.map((item) {
        return {
          'productName': item['productName'],
          'quantity': item['quantity'],
          'price': item['price'],
          'totalPrice': item['price'] * item['quantity'],
        };
      }).toList();

      await orders.add({
        'orderDate': Timestamp.now(),
        'items': orderItems,
        'totalAmount': orderItems.fold(0.0, (sum, item) => sum + item['totalPrice']),
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Order placed successfully!')));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to place order: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = 0.0;

    cart.forEach((item) {
      totalPrice += item['price'] * item['quantity'];
    });

    return Scaffold(
      appBar: const CustomAppBar(title: 'Cart'),
      body: cart.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          var item = cart[index];
          double itemTotalPrice = item['price'] * item['quantity'];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              title: Text(item['productName']),
              subtitle: Text(
                  'Price: ₹${item['price']} x ${item['quantity']} = ₹$itemTotalPrice'),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total: ₹$totalPrice',
                style: const TextStyle(fontSize: 18),
              ),
              ElevatedButton(
                onPressed: () => _checkout(context),
                child: const Text('Checkout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
