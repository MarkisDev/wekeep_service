import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';

class ShopModel {
  late String name;
  late String email;
  late String id;
  late String photoUrl;
  String? address;
  String? phoneNum;
  String? shopName;
  GeoFirePoint? location;

  ShopModel(
      {required this.name,
      required this.email,
      required this.id,
      required this.photoUrl,
      this.phoneNum,
      this.address,
      this.shopName,
      this.location});

  ShopModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    name = documentSnapshot['name'];
    phoneNum = documentSnapshot['phoneNum'];

    address = documentSnapshot['address'];

    photoUrl = documentSnapshot['photoUrl'];
    email = documentSnapshot['email'];
    shopName = documentSnapshot['shopName'];
    GeoPoint geopoint = documentSnapshot['location']['geopoint'];

    location = Geoflutterfire()
        .point(latitude: geopoint.latitude, longitude: geopoint.longitude);
  }
}
