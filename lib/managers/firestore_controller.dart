import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/item.dart';
import '../models/user.dart';

class FirestoreController extends GetxController {
  static FirestoreController get instance => Get.find();


  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Future<void> addItem(Map<String, dynamic> itemDataMap) async {
  //   // Call the user's CollectionReference to add a new user
  //   await _db
  //       .collection('items')
  //       .doc(AuthController.authInstance.currentUserId())
  //       .collection("itemCollection")
  //       .doc(itemDataMap["id"])
  //       .set(itemDataMap)
  //       .then((value) => print("Success to addItem"))
  //       .catchError((error) => print("Failed to addItem: $error"));
  // }

  // Future<void> updateItem(Map<String, dynamic> itemDataMap) async {
  //   await _db
  //       .collection('items')
  //       .doc(AuthController.authInstance.currentUserId())
  //       .collection("itemCollection")
  //       .doc(itemDataMap["id"])
  //       .update(itemDataMap)
  //       .then((value) => print("Success to addItem"))
  //       .catchError((error) => print("Failed to addItem: $error"));
  // }
  //
  // Future<void> deleteItem(String id) async {
  //   await  _db
  //       .collection('items')
  //       .doc(AuthController.authInstance.currentUserId())
  //       .collection("itemCollection")
  //       .doc(id)
  //       .delete()
  //       .then((value) => print("Success to removeItem"))
  //       .catchError((error) => print("Failed to removeItem: $error"));
  // }
  //
  // Future<List<Item>> readItem() async {
  //   final document = await _db
  //       .collection('items')
  //       .doc(AuthController.authInstance.currentUserId())
  //       .collection("itemCollection").orderBy("createdDate", descending: true)
  //       .get();
  //
  //   final allData =
  //   document.docs.map((doc) => cardModelFromMap(doc.data())).toList();
  //
  //   return allData;
  // }

  Future<User> getUser(String documentId) async {
    final documentReference = _db.collection('users').doc(documentId);

    final documentSnapshot = await documentReference.get();
    Map<String, dynamic>? data = documentSnapshot.data();

    if (data != null) {
       return userModelFromMap(data, documentId);
    } else {
      throw Exception('Document not found');
    }
  }
}