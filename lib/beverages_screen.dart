import 'package:flutter/material.dart';
import 'package:food_app_2/database.dart';
import 'selection_screen.dart';
import 'main.dart';

class BeveragesScreen extends StatelessWidget {
  final List<FoodItem> foodItems = [
    FoodItem('Dal Rice Bowls', 'Classic Indian Comfort', 'assets/images/dal_rice.jpg', 10.35),
    FoodItem('Chettinad Rice Bowls', 'South Indian Delight', 'assets/images/chettinad_rice.jpg', 10.35),
    FoodItem('Kadai Rice Bowls', 'Sizzling Kadai Magic', 'assets/images/kadai_rice.jpg', 10.35),
    FoodItem('Paneer Rice Bowls', 'Paneer Paradise in a Bowl', 'assets/images/paneer_rice.jpg', 10.35),
    FoodItem('Masala Pulao', 'Flavorful Masala Infusion', 'assets/images/masala_pulao.jpg', 10.35),
    FoodItem('Hyderabadi Rice', 'Rice with Hyderabadi Twist', 'assets/images/hyderabadi_rice.jpg', 10.35),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Select your Beverages',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Indian',
            style: TextStyle(color: Colors.orange, fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(height: 16),
        Expanded(
          child: GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            padding: EdgeInsets.symmetric(horizontal: 16),
            children: foodItems.map((item) {
              return GestureDetector(
                onTap: () {
                  updateClicked(item.title);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelectionScreen(foodItem: item),
                    ),
                  );
                },
                child: FoodCard(item),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class FoodCard extends StatelessWidget {
  final FoodItem foodItem;

  FoodCard(this.foodItem);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                foodItem.imagePath,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  foodItem.title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  foodItem.subtitle,
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
                SizedBox(height: 8),
                Text(
                  '\$${foodItem.price.toStringAsFixed(2)}',
                  style: TextStyle(color: Colors.orange, fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
