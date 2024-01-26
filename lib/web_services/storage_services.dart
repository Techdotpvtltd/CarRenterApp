import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  StorageService();

  Future<String> uploadImage(
      {required String? withImagePath,
      required String collectionPath,
      required File file}) async {
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': file.path},
    );
    final Reference ref = _storage.ref().child(collectionPath);
    final UploadTask uploadTask = ref.putFile(file, metadata);
    return await uploadTask.snapshot.ref.getDownloadURL();
  }
}
