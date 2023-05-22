import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  late String name;
  late String email;
  late String id;
  late String photoUrl;
  late String token;

  UserModel(
      {required this.name,
      required this.email,
      required this.id,
      required this.photoUrl,
      required this.token});

  UserModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    name = documentSnapshot['name'];
    photoUrl = documentSnapshot['photoUrl'];
    email = documentSnapshot['email'];
    token = documentSnapshot['token'];
  }
}
