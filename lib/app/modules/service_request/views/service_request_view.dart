import 'package:atf/app/data/models/request_model.dart';
import 'package:atf/app/modules/service_request/views/serviceDetails_view.dart';
import 'package:atf/app/ui/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/getwidget.dart';

import 'package:get/get.dart';

import '../controllers/service_request_controller.dart';

class ServiceRequestView extends GetView<ServiceRequestController> {
  @override
  Widget build(BuildContext context) {
    var height = Get.height;
    var width = Get.width;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: height * 0.21,
            decoration: BoxDecoration(
                color: kprimaryColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GFAvatar(
                    shape: GFAvatarShape.standard,
                    backgroundImage: NetworkImage(controller
                        .authenticationController.auth.currentUser!.photoURL
                        .toString()),
                    size: 30,
                  ),
                  Text(
                    "${controller.shopModel.shopName.toString()}!",
                    style: TextStyle(
                        fontSize: 24,
                        // fontWeight: FontWeight,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GFButton(
                          onPressed: () async {
                            await controller.authenticationController
                                .logoutGoogle();
                          },
                          icon: Icon(Icons.logout),
                          color: Colors.white,
                          text: ('Logout'),
                          textColor: Colors.black,
                        ),
                        GFButton(
                          onPressed: () {},
                          color: Color(0xff1d1d1d),
                          text: ('Support'),
                          icon: Icon(
                            Icons.support_agent_outlined,
                            color: Colors.white,
                          ),
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  )
                ]),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: (controller.requestList.length != 0)
                ? Text(
                    (controller.requestList.length != 1)
                        ? '${controller.requestList.length} service requests!'
                        : '${controller.requestList.length} service request!',
                    style: TextStyle(fontSize: 21),
                  )
                : Text(''),
          ),
          Obx(() {
            return Expanded(
              child: (controller.requestList.length == 0)
                  ? Column(
                      children: [
                        Container(
                          child: SvgPicture.asset('assets/images/notify.svg'),
                          height: height * 0.4,
                          width: width * 0.5,
                        ),
                        Text(
                          'No requests right now, keep waiting!',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    )
                  : ListView.builder(
                      itemCount: controller.requestList.length,
                      itemBuilder: (BuildContext context, int index) {
                        final _requestModel = controller.requestList[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.3),
                          child: InkWell(
                            onTap: () {
                              Get.to(ServiceDetailsView(),
                                  arguments: _requestModel);
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 0.2,
                                      blurRadius: 12,
                                      offset: Offset(0, 7),
                                    )
                                  ]),
                              child: GFListTile(
                                avatar: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: GFAvatar(
                                    backgroundImage: NetworkImage(
                                        _requestModel.userPhotoUrl.toString()),
                                    size: 30,
                                  ),
                                ),
                                icon: IconButton(
                                  icon: Icon(Icons.directions),
                                  onPressed: () {},
                                ),
                                titleText: _requestModel.name,
                                subTitleText:
                                    "Requested by ${_requestModel.userName}",
                              ),
                            ),
                          ),
                        );
                        // return GestureDetector(
                        //   onTap: () {
                        //     Get.to(ServiceDetailsView(),
                        //         arguments: _requestModel);
                        //   },
                        //   child: Card(
                        //     child: ListTile(
                        //       title: Text("${_requestModel.name}"),
                        //       subtitle: Text("${_requestModel.desc}"),
                        //       trailing: Icon(Icons.directions),
                        //     ),
                        //   ),
                        // );
                      }),
            );
          })
          // Expanded(
          //   child: ListView(
          //     children: [
          //       GestureDetector(
          //         onTap: () {
          //           ServiceDetails serviceProvider = ServiceDetails(
          //               name: 'Raghav Bhagvati',
          //               desc: 'Battery not working!',
          //               imgUrl:
          //                   'https://previews.123rf.com/images/milkos/milkos1707/milkos170701196/81782912-repairing-mobile-phone-smartphone-diagnostic-at-service-center-repairman-workplace.jpg');
          //           Get.to(ServiceDetailsView(), arguments: serviceProvider);
          //         },
          //         child: Card(
          //           child: ListTile(
          //             title: Text('Phone service'),
          //             subtitle: Text('- Raghav Bhagvati'),
          //             trailing: Icon(Icons.directions),
          //           ),
          //         ),
          //       ),
          //       GestureDetector(
          //         onTap: () {
          //           ServiceDetails serviceProvider = ServiceDetails(
          //               name: 'Rijuth Menon',
          //               desc: 'Please help!',
          //               imgUrl:
          //                   'https://previews.123rf.com/images/milkos/milkos1707/milkos170701196/81782912-repairing-mobile-phone-smartphone-diagnostic-at-service-center-repairman-workplace.jpg');
          //           Get.to(ServiceDetailsView(), arguments: serviceProvider);
          //         },
          //         child: Card(
          //           child: ListTile(
          //             title: Text('Tablet Service'),
          //             subtitle: Text('- Rijuth Menon'),
          //             trailing: Icon(Icons.directions),
          //           ),
          //         ),
          //       ),
          //       GestureDetector(
          //         onTap: () {
          //           ServiceDetails serviceProvider = ServiceDetails(
          //               name: 'Babita Kumari',
          //               desc: 'Screen broken',
          //               imgUrl:
          //                   'https://previews.123rf.com/images/milkos/milkos1707/milkos170701196/81782912-repairing-mobile-phone-smartphone-diagnostic-at-service-center-repairman-workplace.jpg');
          //           Get.to(ServiceDetailsView(), arguments: serviceProvider);
          //         },
          //         child: Card(
          //           child: ListTile(
          //             title: Text('iPad Service'),
          //             subtitle: Text('- Babita Kumari'),
          //             trailing: Icon(Icons.directions),
          //           ),
          //         ),
          //       ),
          //       GestureDetector(
          //         onTap: () {
          //           ServiceDetails serviceProvider = ServiceDetails(
          //               name: 'Rakesh Mishra',
          //               desc: 'Not working!!!',
          //               imgUrl:
          //                   'https://previews.123rf.com/images/milkos/milkos1707/milkos170701196/81782912-repairing-mobile-phone-smartphone-diagnostic-at-service-center-repairman-workplace.jpg');
          //           Get.to(ServiceDetailsView(), arguments: serviceProvider);
          //         },
          //         child: Card(
          //           child: ListTile(
          //             title: Text('iPhone Service'),
          //             subtitle: Text('- Rakesh Mishra'),
          //             trailing: Icon(Icons.directions),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
