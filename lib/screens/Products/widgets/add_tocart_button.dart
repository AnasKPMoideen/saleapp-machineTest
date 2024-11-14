import 'package:flutter/material.dart';
import '../../Cart/cart_screen.dart';

class CartButton extends StatelessWidget {
  final List<Map<String, dynamic>> cart;

  const CartButton({Key? key, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return cart.isNotEmpty
        ? Positioned(
      bottom: 20,
      left: 0,
      right: 0,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartScreen(cart: cart),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15),
          color: Colors.blue,
          child: Center(
            child: Text(
              'View Cart (${cart.length} items)',
              style: const TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
        ),
      ),
    )
        : Container();
  }
}
