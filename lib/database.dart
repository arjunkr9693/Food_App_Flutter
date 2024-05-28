import 'package:cloud_firestore/cloud_firestore.dart';

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> updateClicked(String itemName) async {
    try {
      DocumentReference itemRef = firestore.collection('items').doc(itemName);
      DocumentSnapshot itemSnapshot = await itemRef.get();

      if (itemSnapshot.exists) {
        await itemRef.update({'clicked': FieldValue.increment(1)});
      } else {
        await itemRef.set({
          'clicked': 1,
          'addedToCart': 0,
        });
      }
      print('Clicked count updated successfully');
    } catch (e) {
      print('Error updating clicked count: $e');
    }
  }

  Future<void> updateAddedToCart(String itemName) async {
    try {
      DocumentReference itemRef = firestore.collection('items').doc(itemName);
      await itemRef.update({'addedToCart': FieldValue.increment(1)});

      print('Added to cart count updated successfully');
    } catch (e) {
      print('Error updating added to cart count: $e');
    }
  }
