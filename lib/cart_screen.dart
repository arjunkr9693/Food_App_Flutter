import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Consumer<CartModel>(
        builder: (context, cart, child) {
          return cart.itemCount == 0
              ? Center(child: Text('Your cart is empty'))
              : ListView.builder(
                  itemCount: cart.itemCount,
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return ListTile(
                      leading: Image.asset(item.imagePath, fit: BoxFit.cover),
                      title: Text(item.title),
                      subtitle: Text(item.subtitle),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          cart.remove(item);
                        },
                      ),
                    );
                  },
                );
        },
      ),
      bottomNavigationBar: Consumer<CartModel>(
        builder: (context, cart, child) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total: \$${cart.totalPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }
}
