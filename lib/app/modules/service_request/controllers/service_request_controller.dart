import 'dart:convert';

import 'package:atf/app/data/models/request_model.dart';
import 'package:atf/app/data/models/shop_model.dart';
import 'package:atf/app/data/repositories/service_repository.dart';
import 'package:atf/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ServiceRequestController extends GetxController {
  final ServiceRepository repository;
  final authenticationController = Get.find<AuthenticationController>();

  ServiceRequestController({required this.repository});
  final shopModel = Get.arguments;

  final requestList = <RequestModel>[].obs;
// Getter to get all the products from the list
  List<RequestModel> get products => requestList.value;
  final count = 0.obs;

  void sendPushMessage(String body, String title, String token) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAWZYjxhM:APA91bGZA5_ildtro8NM2LSTSALcBDWvwSUjdDwIgvbEDYzW_eix1cKUky2L0VPoWX_8Veo-ibEq5OMYCoW4WOyU-bZ2326ptv0HSg-DZL75MoLxOdVMOlUvlsjhFfdRp00jZLFoRbee',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': body,
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": token,
          },
        ),
      );
      print('done');
    } catch (e) {
      print("error push notification");
    }
  }

  @override
  void onInit() {
    super.onInit();
    requestList.bindStream(repository
        .requestStream(authenticationController.auth.currentUser!.uid));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
