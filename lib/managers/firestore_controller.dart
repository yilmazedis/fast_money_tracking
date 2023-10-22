import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/item.dart';
import '../models/user.dart';

class FirestoreController extends GetxController {
  static FirestoreController get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  void enablePersistent() {
    _db.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  }

  Future<void> addItem(Map<String, dynamic> itemDataMap, String companyId) async {
    // Call the user's CollectionReference to add a new user
    await _db
        .collection('companies')
        .doc(companyId)
        .collection("items")
        .doc()
        .set(itemDataMap)
        .then((value) => print("Success to addItem"))
        .catchError((error) => print("Failed to addItem: $error"));
  }

  Future<void> updateItem(Map<String, dynamic> itemDataMap, String companyId) async {
    await _db
        .collection('companies')
        .doc(companyId)
        .collection("items")
        .doc(itemDataMap["id"])
        .update(itemDataMap)
        .then((value) => print("Success to updateItem"))
        .catchError((error) => print("Failed to updateItem: $error"));
  }

  Future<void> deleteItem(String id, String companyId) async {
    await  _db
        .collection('companies')
        .doc(companyId)
        .collection("items")
        .doc(id)
        .delete()
        .then((value) => print("Success to deleteItem"))
        .catchError((error) => print("Failed to deleteItem: $error"));
  }

  void itemListener(
      {required Function(List<Item>) onAdd,
      required Function(List<String>) onRemove,
      required Function(List<Item>) onUpdate,
      required String companyId}) {
    _db
        .collection('companies')
        .doc(companyId)
        .collection("items")
        .orderBy("date", descending: true)
        .snapshots()
        .listen((event) {
      List<Item> addedItems = [];
      List<String> removedItemIds = [];
      List<Item> updatedItems = [];
      for (var change in event.docChanges) {
        if (change.type == DocumentChangeType.added) {
          // Handle added document
          addedItems.add(itemModelFromMap(change.doc.data()!, change.doc.id));
        } else if (change.type == DocumentChangeType.modified) {
          // Handle modified document
          updatedItems.add(itemModelFromMap(change.doc.data()!, change.doc.id));
        } else if (change.type == DocumentChangeType.removed) {
          // Handle removed document
          removedItemIds.add(change.doc.id);
        }
      }
      onAdd(addedItems);
      onRemove(removedItemIds);
      onUpdate(updatedItems);
    });
  }

  // final allData =
  // event.docs.map((doc) {
  //   return itemModelFromMap(doc.data(), doc.id);
  // }).toList();
  // callback(allData);

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