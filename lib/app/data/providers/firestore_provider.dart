import 'package:atf/app/data/models/shop_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';

class FirestoreDb {
  static final FirebaseFirestore _firebaseFirestore =
      FirebaseFirestore.instance;

  //------------User Related Functions----------
  static addShop(ShopModel shopModel, String uid) async {
    await _firebaseFirestore.collection('shops').doc(uid).set({
      'name': shopModel.name,
      'email': shopModel.email,
      'id': shopModel.id,
      'photoUrl': shopModel.photoUrl,
    });
  }

  static getShop(String id) async {
    return await _firebaseFirestore
        .collection('shops')
        .where('id', isEqualTo: id)
        .get();
  }

  static addShopDetails(String shopName, String phoneNum, String address,
      String uid, GeoFirePoint pos) async {
    await _firebaseFirestore.collection('shops').doc(uid).update({
      'address': address,
      'phoneNum': phoneNum,
      'shopName': shopName,
      'location': pos.data,
    });
  }

  static Future<bool> doesShopExist(String id) async {
    var docs = await _firebaseFirestore
        .collection('shops')
        .where('id', isEqualTo: id)
        .get();
    if (docs.size == 1) {
      return true;
    }
    return false;
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> requestStream(String uid) {
    return _firebaseFirestore
        .collection('shops')
        .doc(uid)
        .collection('requests')
        .snapshots();
  }

  static deleteRequest(String requestDocId, String shopId) async {
    // QuerySnapshot requestDoc = await _firebaseFirestore
    //     .collection('shops')
    //     .where('id', isEqualTo: userId)
    //     .get();

    await _firebaseFirestore
        .collection('shops')
        .doc(shopId)
        .collection('requests')
        .doc(requestDocId)
        .delete();
  }

  static getUser(String id) async {
    return await _firebaseFirestore
        .collection('users')
        .where('id', isEqualTo: id)
        .get();
  }
}
