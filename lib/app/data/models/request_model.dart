import 'package:cloud_firestore/cloud_firestore.dart';

class RequestModel {
  late String img;
  late String desc;
  late String name;
  late String userName;
  late String userPhotoUrl;
  String? id;
  late String uid;
  late String token;
  RequestModel(
      {required this.img,
      required this.userName,
      required this.userPhotoUrl,
      required this.name,
      required this.desc,
      this.id,
      required this.uid,
      required this.token});

  /// Constructor to init variables from Firebase
  RequestModel.fromDocumentSnapshot(
      {required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    name = documentSnapshot['name'];
    img = documentSnapshot['img'];
    desc = documentSnapshot['desc'];
    uid = documentSnapshot['uid'];
    token = documentSnapshot['token'];
    userName = documentSnapshot['userName'];
    userPhotoUrl = documentSnapshot['userPhotoUrl'];
  }
}
