import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostImage {
  final firestoreInstance = FirebaseFirestore.instance;

  // ignore: non_constant_identifier_names
  Future<String> PostImageToCloud(File image) async {
    StorageReference reference = FirebaseStorage.instance
        .ref()
        .child('${DateTime.now().millisecondsSinceEpoch.toString()}.png');
    StorageUploadTask uploadTask = reference.putFile(image);
    StorageTaskSnapshot storageTaskSnapshot;
    storageTaskSnapshot = await uploadTask.onComplete;
    if (storageTaskSnapshot.error == null) {
      return await storageTaskSnapshot.ref.getDownloadURL();
    } else {
      return null;
    }
  }

  // ignore: missing_return
  Future<Object> getInfoUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var infoUser =
        Firestore.instance.collection('user').doc(prefs.getString('uid'));
    infoUser.get().then((value) {
      return value;
    });
  }
}
