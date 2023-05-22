import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('HomeView'),
          centerTitle: true,
        ),
        body: Container(
          child: Column(children: [
            Form(
                key: controller.formKey,
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(children: [
                      Center(child: Text('Enter shop details')),
                      TextFormField(
                        controller: controller.nameController,
                        decoration: const InputDecoration(labelText: 'Name'),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Name is not valid!';
                          } else {
                            return null;
                          }
                        },
                      ),
                      TextFormField(
                        controller: controller.numController,
                        decoration:
                            const InputDecoration(labelText: 'Phone Number'),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Number is not valid!';
                          } else {
                            return null;
                          }
                        },
                      ),
                      TextFormField(
                        controller: controller.addressController,
                        decoration: const InputDecoration(labelText: 'Address'),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Address is not valid!';
                          } else {
                            return null;
                          }
                        },
                      ),
                    ]))),
            Text('Your current location will be taken as shop address!'),
            ElevatedButton(
                onPressed: () {
                  controller.addShop();
                  // Get.offNamed('/service-request',
                  //     arguments: controller.shopModel);
                  // Get.offNamed('/authentication');
                },
                child: Text('SAVE!'))
          ]),
        ));
  }
}
