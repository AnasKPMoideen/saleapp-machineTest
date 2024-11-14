import 'package:flutter/material.dart';
import '../../../Models/product_model.dart';

class ProductListItem extends StatefulWidget {
  final Product product;
  final List<Map<String, dynamic>> cart;
  final Function(String, String, double, int) updateCart;

  const ProductListItem({
    Key? key,
    required this.product,
    required this.cart,
    required this.updateCart,
  }) : super(key: key);

  @override
  _ProductListItemState createState() => _ProductListItemState();
}

class _ProductListItemState extends State<ProductListItem> {
  int _counter = 0;

  // Increment the counter for the product
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    if (_counter > 0) {
      setState(() {
        _counter--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalPrice = widget.product.price * _counter;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                title: Text(widget.product.productName),
                subtitle: Text(
                  'Price: ₹${widget.product.price.toStringAsFixed(2)}, Tax: ${widget.product.taxPercentage.toStringAsFixed(2)}%\nTotal: ₹${totalPrice.toStringAsFixed(2)}',
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: _decrementCounter,
                  ),
                  Text(
                    '$_counter',
                    style: const TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _incrementCounter,
                  ),
                  ElevatedButton(
                    onPressed: _counter > 0
                        ? () {
                      widget.updateCart(
                        widget.product.productId,
                        widget.product.productName,
                        widget.product.price,
                        _counter,
                      );
                    }
                        : null,
                    child: const Text('Add to Cart'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
