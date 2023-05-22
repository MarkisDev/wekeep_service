import 'package:atf/app/data/models/shop_model.dart';
import 'package:atf/app/data/providers/firestore_provider.dart';
import 'package:atf/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  final geo = Geoflutterfire();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var numController = TextEditingController();
  var addressController = TextEditingController();
  ShopModel shopModel = Get.arguments;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nameController.dispose();
  }

  addShop() async {
    final authenticationController = Get.find<AuthenticationController>();
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    var x = await Geolocator.getCurrentPosition();
    GeoFirePoint pos = geo.point(latitude: x.latitude, longitude: x.longitude);

    await FirestoreDb.addShopDetails(
        nameController.text,
        numController.text,
        addressController.text,
        authenticationController.auth.currentUser!.uid,
        pos);

    // var querySnapshot = await FirestoreDb.getShop(shopModel.id);
    // ShopModel usr =
    //     ShopModel.fromDocumentSnapshot(documentSnapshot: querySnapshot.docs[0]);
    // shopModel = usr;

    authenticationController.loginWithGoogle();
  }
}
