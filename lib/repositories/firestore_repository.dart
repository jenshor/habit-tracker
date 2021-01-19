import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/models/model.dart';

@immutable
class FirestoreRepository<Item extends Model> {
  final String _collectionParentPath;

  final Item Function(Map<String, dynamic>) _mapDataToItem;

  @protected
  final String collectionName;

  @protected
  final FirebaseFirestore firestore;

  @protected
  CollectionReference get collection =>
      this.firestore.collection(collectionPath);

  @protected
  String get collectionPath {
    String colPath = collectionName;
    if (this._collectionParentPath != null) {
      colPath = '$_collectionParentPath/$colPath';
    }
    return colPath;
  }

  FirestoreRepository(
    this.collectionName,
    Item Function(Map<String, dynamic>) mapDataToItem, {
    FirebaseFirestore firestore,
    String collectionParentPath,
  })  : this._mapDataToItem = mapDataToItem,
        this.firestore = firestore ?? FirebaseFirestore.instance,
        this._collectionParentPath = collectionParentPath;

  DocumentReference getDocument(String id) {
    return collection.doc(id);
  }

  Future<String> addItem(Item item) async {
    DocumentReference document = await collection.add(item.toMap());
    return document.id;
  }

  DocumentReference getItem(Item item) {
    return getDocument(item.id.value);
  }

  Future updateItem(Item item) {
    return getItem(item).update(item.toMap());
  }

  Future deleteItem(Item item) {
    return getDocument(item.id.value).delete();
  }

  Future<DocumentSnapshot> getSnapshot(String id) {
    return getDocument(id).get();
  }

  Stream<QuerySnapshot> _getSnapshots() {
    return collection.snapshots();
  }

  List<Item> getListOfItemsFromQuerySnapshot(
    QuerySnapshot querySnapshot,
  ) {
    return querySnapshot.docs
        .map((
          QueryDocumentSnapshot documentSnapshot,
        ) =>
            _mapDataToItem(
              documentSnapshot.data(),
            ))
        .toList();
  }

  Stream<List<Item>> getStreamOfItems() {
    return this
        ._getSnapshots()
        .map((QuerySnapshot querySnapshot) => getListOfItemsFromQuerySnapshot(
              querySnapshot,
            ));
  }
}
