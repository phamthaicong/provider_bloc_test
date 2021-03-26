import 'package:cloud_firestore/cloud_firestore.dart';

class PostBloc {
  final fireStoreInstance = FirebaseFirestore.instance;

  PostNews(String imageUser,String uid,String imageUrl, String writePost, String userCreator,
      String timetamp) async {
    fireStoreInstance.collection('post').add({
      "imageUser":imageUser,
      "userId":uid,
      "imageUrl":imageUrl,
      "writePost":writePost,
      "userCreator":userCreator,
      "timetamp":timetamp
    });
  }
}
