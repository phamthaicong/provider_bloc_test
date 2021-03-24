import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class PostImage {
  Future<String> PostImageToCloud(File image) async {
    StorageReference reference = FirebaseStorage.instance
        .ref()
        .child('${DateTime.now().millisecondsSinceEpoch.toString()}.png');
    StorageUploadTask uploadTask = reference.putFile(image);
    StorageTaskSnapshot storageTaskSnapshot;
    storageTaskSnapshot = await uploadTask.onComplete;
    if (storageTaskSnapshot.error == null) {
      return await storageTaskSnapshot.ref.getDownloadURL();
    }else{
      return null;
    }
  }
}
