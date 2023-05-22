import 'package:atf/app/data/models/shop_model.dart';
import 'package:atf/app/data/providers/firestore_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShopRepository {
  addShop(ShopModel shopModel, String uid) async {
    await FirestoreDb.addShop(shopModel, uid);
  }

  getShop(String id) async {
    var querySnapshot = await FirestoreDb.getShop(id);
    var doc = querySnapshot.docs[0].data();
    ShopModel usr = ShopModel.fromDocumentSnapshot(documentSnapshot: doc);
    print(usr.email);
    return usr;
  }
}
