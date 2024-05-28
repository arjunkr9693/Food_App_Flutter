import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_model.dart';
import 'cart_screen.dart';
import 'rice_bowls_screen.dart';
import 'pasta_bowls_screen.dart';
import 'sides_screen.dart';
import 'beverages_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: FoodSelectionApp(),
    ),
  );
}

class FoodSelectionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Selection App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _selectedScreen = RiceBowlsScreen();
  String _selectedMenuItem = 'Rice Bowls';

  void _onMenuItemTapped(String menuItem, Widget screen) {
    setState(() {
      _selectedMenuItem = menuItem;
      _selectedScreen = screen;
    });
    Navigator.pop(context); // Close the drawer
  }

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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.orange,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.rice_bowl),
              title: Text('Rice Bowls'),
              selected: _selectedMenuItem == 'Rice Bowls',
              selectedTileColor: Colors.orangeAccent,
              onTap: () => _onMenuItemTapped('Rice Bowls', RiceBowlsScreen()),
            ),
            ListTile(
              leading: Icon(Icons.fastfood),
              title: Text('Pasta Bowls'),
              selected: _selectedMenuItem == 'Pasta Bowls',
              selectedTileColor: Colors.orangeAccent,
              onTap: () => _onMenuItemTapped('Pasta Bowls', PastaBowlsScreen()),
            ),
            ListTile(
              leading: Icon(Icons.local_dining),
              title: Text('Sides'),
              selected: _selectedMenuItem == 'Sides',
              selectedTileColor: Colors.orangeAccent,
              onTap: () => _onMenuItemTapped('Sides', SidesScreen()),
            ),
            ListTile(
              leading: Icon(Icons.local_drink),
              title: Text('Beverages'),
              selected: _selectedMenuItem == 'Beverages',
              selectedTileColor: Colors.orangeAccent,
              onTap: () => _onMenuItemTapped('Beverages', BeveragesScreen()),
            ),
          ],
        ),
      ),
      body: _selectedScreen,
    );
  }
}

class FoodItem {
  final String title;
  final String subtitle;
  final String imagePath;
  final double price;

  FoodItem(this.title, this.subtitle, this.imagePath, this.price);
}
