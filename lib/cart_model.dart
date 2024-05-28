import 'package:flutter/foundation.dart';

class CartItem {
  final String title;
  final String subtitle;
  final double price;
  final String imagePath;

  CartItem({required this.title, required this.subtitle, required this.price, required this.imagePath});
}

class CartModel extends ChangeNotifier {
  final List<CartItem> _items = [];

  List<CartItem> get items => _items;

  int get itemCount => _items.length;

  double get totalPrice => _items.fold(0.0, (total, current) => total + current.price);

  void add(CartItem item) {
    _items.add(item);
    notifyListeners();
  }

  void remove(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }
}
