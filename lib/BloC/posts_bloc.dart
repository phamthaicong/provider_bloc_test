import 'package:cloud_firestore/cloud_firestore.dart';

class PostBloc {
  final fireStoreInstance = FirebaseFirestore.instance;

  PostNews(String uid,String imageUrl, String writePost, String userCreator,
      String timetamp) async {
    var abc = await fireStoreInstance.collection('post').add({
      "userId":uid,
      "imageUrl":imageUrl,
      "writePost":writePost,
      "userCreator":userCreator,
      "timetamp":timetamp
    });
  }
}
