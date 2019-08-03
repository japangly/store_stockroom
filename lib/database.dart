import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Database {
  Stream<QuerySnapshot> getStreamCollection({
    @required String collection,
    @required String orderBy,
    @required bool isDescending,
  }) {
    return Firestore.instance
        .collection(collection)
        .orderBy(
          orderBy,
          descending: isDescending,
        )
        .snapshots();
  }

  Future<QuerySnapshot> getCurrentUserInfo() async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      QuerySnapshot querySnapshot = await Firestore.instance
          .collection('employees')
          .where('uid', isEqualTo: sharedPreferences.get('token'))
          .limit(1)
          .getDocuments();
      return querySnapshot;
    } catch (e) {
      return null;
    }
  }

  Future<List<DocumentSnapshot>> getAllCollection({
    @required String collection,
    @required String sortBy,
    @required bool order,
  }) async {
    QuerySnapshot snapshot = await Firestore.instance
        .collection(collection)
        .orderBy(sortBy, descending: order)
        .getDocuments();
    return snapshot.documents;
  }

  Future createCollection(
      {@required String collection,
      @required Map<String, dynamic> data}) async {
    await Firestore.instance
        .collection(collection)
        .add(data)
        .catchError((error) {
      return error.toString();
    });
  }

  Future updateCollection({
    @required String collection,
    @required String documentId,
    @required Map<String, dynamic> data,
  }) async {
    await Firestore.instance
        .collection(collection)
        .document(documentId)
        .updateData(data)
        .catchError((e) {
      print(e);
    });
  }

  Future deleteCollection({
    @required String collection,
    @required String documentId,
  }) async {
    await Firestore.instance
        .collection(collection)
        .document(documentId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }

  Future<DocumentSnapshot> getCollectionByDocumentId({
    @required String collection,
    @required String documentId,
  }) async {
    return await Firestore.instance
        .collection(collection)
        .document(documentId)
        .get();
  }

  Future<DocumentSnapshot> getCollectionByField({
    @required String collection,
    @required String field,
    @required String value,
  }) async {
    try {
      QuerySnapshot snapshot = await Firestore.instance
          .collection(collection)
          .where(field, isEqualTo: value)
          .limit(1)
          .getDocuments();
      return snapshot.documents.first;
    } catch (e) {
      return null;
    }
  }
}
