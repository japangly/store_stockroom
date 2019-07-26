import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_native_image/flutter_native_image.dart';

class Storage {
  Future<String> uploadFile({
    @required String collection,
    @required File file,
    @required String fileName,
  }) async {
    StorageReference reference =
        FirebaseStorage.instance.ref().child(collection).child(fileName);

    File compressedFile = await FlutterNativeImage.compressImage(file.path);

    StorageUploadTask uploadTask = reference.putFile(compressedFile);
    StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    return await downloadUrl.ref.getDownloadURL();
  }

  Future getFileUrl({
    @required String collection,
    @required String fileName,
  }) async {
    Future<StorageReference> ref = FirebaseStorage.instance.getReferenceFromUrl(
        'gs://mickey-salon.appspot.com/$collection/$fileName');
    return await ref.then((doc) => doc.getDownloadURL());
  }

  Future<String> deleteFile({
    @required String collection,
    @required String fileName,
  }) async {
    FirebaseStorage storage =
        FirebaseStorage(storageBucket: 'gs://mickey-salon.appspot.com');
    await storage
        .ref()
        .child('$collection/$fileName')
        .delete()
        .catchError((onError) {
      return onError.toString();
    });
    return 'deleted';
  }

  Future updateFile({
    @required String collection,
    @required File file,
    @required String fileName,
  }) async {
    deleteFile(collection: collection, fileName: fileName).whenComplete(() {
      return uploadFile(collection: collection, file: file, fileName: fileName);
    });
  }
}
