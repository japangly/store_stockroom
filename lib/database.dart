import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class Database {
  Future<DocumentSnapshot> getCurrentUserInfo({@required String userId}) async {
    QuerySnapshot querySnapshot = await Firestore.instance
        .collection('employees')
        .where('uid', isEqualTo: userId)
        .limit(1)
        .getDocuments();
    return querySnapshot.documents.first;
  }

  Future<List<DocumentSnapshot>> getAllCollection({
    @required String collection,
    @required String sortBy,
    @required bool order,
  }) async {
    var firestore = Firestore.instance;
    QuerySnapshot qn = await firestore
        .collection(collection)
        .orderBy(sortBy, descending: order)
        .getDocuments();
    return qn.documents;
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
    DocumentSnapshot getcollection = await Firestore.instance
        .collection(collection)
        .document(documentId)
        .get();
    return getcollection;
  }
}
