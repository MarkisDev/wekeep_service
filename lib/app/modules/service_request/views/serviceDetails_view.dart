import 'package:atf/app/data/models/request_model.dart';
import 'package:atf/app/modules/service_request/controllers/service_request_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceDetailsView extends GetView<ServiceRequestController> {
  @override
  Widget build(BuildContext context) {
    RequestModel serviceModel = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('HomeView'),
        centerTitle: true,
      ),
      body: Center(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              '${serviceModel.name}',
              style: TextStyle(fontSize: 21),
            ),
          ),
          Image.network(
            serviceModel.img,
            height: 250,
            width: 250,
          ),
          Card(
              child: ListTile(
                  title: Center(child: Text("${serviceModel.desc} ")),
                  onTap: () {})),
          Card(
              child: ListTile(
            title: Center(child: Text("Avg price  - \u{20B9}1000")),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  controller.sendPushMessage(
                      'Your service request has been accepted!',
                      'Accepted!',
                      serviceModel.token);
                  Get.snackbar(
                    'Success!',
                    'Request accepted!',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    borderRadius: 20,
                    margin: EdgeInsets.all(15),
                    colorText: Colors.white,
                    duration: Duration(seconds: 4),
                    isDismissible: true,
                    dismissDirection: DismissDirection.horizontal,
                    forwardAnimationCurve: Curves.easeOutBack,
                  );
                },
                child: Text('Accept'),
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green)),
              ),
              ElevatedButton(
                  onPressed: () async {
                    controller.sendPushMessage(
                        'Your service request has been rejected!',
                        'Rejected',
                        serviceModel.token);
                    Get.back();

                    Get.snackbar(
                      'Success!',
                      'Request rejected!',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      borderRadius: 20,
                      margin: EdgeInsets.all(15),
                      colorText: Colors.white,
                      duration: Duration(seconds: 4),
                      isDismissible: true,
                      dismissDirection: DismissDirection.horizontal,
                      forwardAnimationCurve: Curves.easeOutBack,
                    );
                    await controller.repository.deleteRequest(
                        serviceModel.id.toString(), controller.shopModel.id);
                  },
                  child: Text('Reject'),
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.red))),
            ],
          )
        ],
      )),
    );
  }
}
