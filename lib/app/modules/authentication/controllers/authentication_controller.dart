import 'package:atf/app/modules/authentication/views/authentication_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:atf/app/data/models/shop_model.dart';
import 'package:atf/app/data/providers/firestore_provider.dart';

class AuthenticationController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  // Logins user using GoogleSignIn
  loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication!.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final authResult = await auth.signInWithCredential(credential);

      ShopModel shopModel = ShopModel(
          name: googleSignInAccount!.displayName.toString(),
          email: googleSignInAccount.email,
          id: googleSignInAccount.id,
          photoUrl: googleSignInAccount.photoUrl.toString());

      bool res = await FirestoreDb.doesShopExist(googleSignInAccount.id);
      if (!res) {
        await FirestoreDb.addShop(shopModel, auth.currentUser!.uid);
        Get.offNamed('/home', arguments: shopModel);
      } else {
        var querySnapshot = await FirestoreDb.getShop(shopModel.id);
        ShopModel usr = ShopModel.fromDocumentSnapshot(
            documentSnapshot: querySnapshot.docs[0]);
        Get.offNamed('/service-request', arguments: usr);
      }
    } catch (e) {
      throw (e);
    }
  }

  /// Logs user out
  Future<void> logoutGoogle() async {
    await googleSignIn.signOut();
    Get.offAll(AuthenticationView());
  }
}
