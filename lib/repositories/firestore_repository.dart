import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/models/id.dart';
import 'package:habit_tracker/models/model.dart';
import 'package:habit_tracker/repositories/repository.dart';

@immutable
class FirestoreRepository<Item extends Model> extends Repository<Item> {
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

  DocumentReference getDocumentByItem(Item item) {
    return getDocument(item.id.value);
  }

  Future<Item> getItem(String id) async {
    DocumentSnapshot documentSnapshot = await getDocument(id).get();
    Map<String, dynamic> data = documentSnapshot.data();
    data = setIdFromDocumentSnapshot(
      data,
      documentSnapshot,
    );
    return _mapDataToItem(data);
  }

  // Can be used to add an item that has an id != null if
  // no item in Firestore with that id exists.
  // e.g. addItem would generate a random id for that item
  // ignoring the already set id
  Future<void> setItem(Item item) async {
    return getDocumentByItem(item).set(item.toMap());
  }

  Future<void> updateItem(Item item) {
    return getDocumentByItem(item).update(item.toMap());
  }

  Future<void> deleteItem(Item item) {
    return getDocument(item.id.value).delete();
  }

  Future<DocumentSnapshot> getSnapshot(String id) {
    return getDocument(id).get();
  }

  Stream<QuerySnapshot> _getSnapshots() {
    return collection.snapshots();
  }

  Map<String, dynamic> setIdFromDocumentSnapshot(
      Map<String, dynamic> data, DocumentSnapshot documentSnapshot) {
    Id id = Id.fromMap(data['id']);
    String documentId = documentSnapshot.id;
    if (id == null) {
      id = Id(documentId);
    } else {
      id = id.copyWith(value: documentId);
    }

    data['id'] = id.toMap();

    return data;
  }

  Map<String, dynamic> prepareDateFromDocumentSnapshot(
      DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data();
    return setIdFromDocumentSnapshot(data, documentSnapshot);
  }

  List<Item> getListOfItemsFromQuerySnapshot(
    QuerySnapshot querySnapshot,
  ) {
    return querySnapshot.docs.map((
      QueryDocumentSnapshot documentSnapshot,
    ) {
      Map<String, dynamic> data =
          prepareDateFromDocumentSnapshot(documentSnapshot);
      return _mapDataToItem(data);
    }).toList();
  }

  Stream<List<Item>> getStreamOfItems() {
    return this
        ._getSnapshots()
        .map((QuerySnapshot querySnapshot) => getListOfItemsFromQuerySnapshot(
              querySnapshot,
            ));
  }
}
