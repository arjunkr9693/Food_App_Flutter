import 'package:flutter/material.dart';
import 'package:food_app_2/database.dart';
import 'package:provider/provider.dart';
import 'main.dart';
import 'cart_model.dart';
import 'cart_screen.dart';

class SelectionScreen extends StatefulWidget {
  final FoodItem foodItem;

  SelectionScreen({required this.foodItem});

  @override
  _SelectionScreenState createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  String? _selectedRice;
  String? _selectedDal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, User'),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                Icon(Icons.shopping_bag_outlined),
                Positioned(
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(1),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 12,
                      minHeight: 12,
                    ),
                    child: Consumer<CartModel>(
                      builder: (context, cart, child) {
                        return Text(
                          '${cart.itemCount}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Home Style Favourites',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              'Indian > Dal Rice',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Image.asset(
                    widget.foodItem.imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.foodItem.title,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        widget.foodItem.subtitle,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'A quintessential Indian comfort food pairing, featuring aromatic basmati rice served with flavorful lentil dal. A hearty, wholesome dish that satisfies the soul with every bite.',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      SizedBox(height: 16),
                      Text(
                        '\$${widget.foodItem.price}',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Choose your rice',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            RadioListTile<String>(
              title: Text('Jeera Rice'),
              subtitle: Text('+\$2.30'),
              value: 'Jeera Rice',
              groupValue: _selectedRice,
              onChanged: (value) {
                setState(() {
                  _selectedRice = value;
                });
              },
            ),
            RadioListTile<String>(
              title: Text('Ghee Rice'),
              subtitle: Text('+\$4.70'),
              value: 'Ghee Rice',
              groupValue: _selectedRice,
              onChanged: (value) {
                setState(() {
                  _selectedRice = value;
                });
              },
            ),
            SizedBox(height: 16),
            Text(
              'Choose your Dal',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            RadioListTile<String>(
              title: Text('Dal Tadka'),
              subtitle: Text('+\$2.30'),
              value: 'Dal Tadka',
              groupValue: _selectedDal,
              onChanged: (value) {
                setState(() {
                  _selectedDal = value;
                });
              },
            ),
            RadioListTile<String>(
              title: Text('Masala Dal'),
              subtitle: Text('+\$4.70'),
              value: 'Masala Dal',
              groupValue: _selectedDal,
              onChanged: (value) {
                setState(() {
                  _selectedDal = value;
                });
              },
            ),
            RadioListTile<String>(
              title: Text('Lasooni Dal'),
              subtitle: Text('+\$2.50'),
              value: 'Lasooni Dal',
              groupValue: _selectedDal,
              onChanged: (value) {
                setState(() {
                  _selectedDal = value;
                });
              },
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_selectedRice != null && _selectedDal != null) {
                    final cartItem = CartItem(
                      title: widget.foodItem.title,
                      subtitle: '${_selectedRice!} + ${_selectedDal!}',
                      price: widget.foodItem.price +
                          _getAdditionalPrice(_selectedRice) +
                          _getAdditionalPrice(_selectedDal),
                      imagePath: widget.foodItem.imagePath,
                    );
                    Provider.of<CartModel>(context, listen: false)
                        .add(cartItem);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Added to cart!'),
                    ));
                    updateAddedToCart(widget.foodItem.title);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please select both rice and dal.'),
                    ));
                  }
                },
                child:
                    Text('Add to Cart', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _getAdditionalPrice(String? selection) {
    switch (selection) {
      case 'Jeera Rice':
        return 2.30;
      case 'Ghee Rice':
        return 4.70;
      case 'Dal Tadka':
        return 2.30;
      case 'Masala Dal':
        return 4.70;
      case 'Lasooni Dal':
        return 2.50;
      default:
        return 0.0;
    }
  }
}
