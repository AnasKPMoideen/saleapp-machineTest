import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:saleapp/screens/Products/widgets/add_tocart_button.dart';
import 'package:saleapp/screens/Products/widgets/product_list_item.dart';
import '../../Models/product_model.dart';
import '../Cart/cart_screen.dart';

class ProductListScreen extends StatefulWidget {
  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final List<Map<String, dynamic>> _cart = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: (){
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios)),
        title: const Text('Products'),
        actions: [
          _cart.isNotEmpty
              ? IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => _navigateToCart(),
          )
              : Container(),
        ],
      ),
      body: Stack(
        children: [
          _buildProductList(),
          if (_cart.isNotEmpty) CartButton(cart: _cart),
        ],
      ),
    );
  }

  Widget _buildProductList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('products').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return const Center(child: Text('Error fetching products'));
        }

        final productDocs = snapshot.data?.docs ?? [];
        if (productDocs.isEmpty) {
          return const Center(child: Text('No products available'));
        }

        return ListView.builder(
          itemCount: productDocs.length,
          itemBuilder: (context, index) {
            var productData = productDocs[index].data() as Map<String, dynamic>;
            var product = Product.fromMap(productData, productDocs[index].id);

            return ProductListItem(
              product: product,
              cart: _cart,
              updateCart: _updateCart,
            );
          },
        );
      },
    );
  }

  void _updateCart(String productId, String productName, double price, int quantity) {
    setState(() {
      var existingProduct = _cart.firstWhere(
            (item) => item['productId'] == productId,
        orElse: () => {},
      );

      if (existingProduct.isNotEmpty) {
        existingProduct['quantity'] = quantity;
      } else {
        _cart.add({
          'productId': productId,
          'productName': productName,
          'price': price,
          'quantity': quantity,
        });
      }
    });
  }

  void _navigateToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(cart: _cart),
      ),
    );
  }
}
