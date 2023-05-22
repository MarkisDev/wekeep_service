import 'package:atf/app/data/repositories/service_repository.dart';
import 'package:atf/app/modules/authentication/controllers/authentication_controller.dart';
import 'package:get/get.dart';

import '../controllers/service_request_controller.dart';

class ServiceRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceRequestController>(
      () => ServiceRequestController(repository: ServiceRepository()),
    );
    Get.lazyPut<AuthenticationController>(
      () => AuthenticationController(),
    );
  }
}
