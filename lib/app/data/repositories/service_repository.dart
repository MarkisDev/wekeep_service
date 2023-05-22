import 'package:atf/app/data/models/request_model.dart';
import 'package:atf/app/data/providers/firestore_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class ServiceRepository {
  requestStream(String uid) {
    var productSnapshots = FirestoreDb.requestStream(uid);
    return productSnapshots.map((QuerySnapshot query) {
      List<RequestModel> requests = [];
      for (var product in query.docs) {
        final productModel =
            RequestModel.fromDocumentSnapshot(documentSnapshot: product);
        requests.add(productModel);
      }
      return requests;
    });
  }

  deleteRequest(String reqDocId, String userId) async {
    await FirestoreDb.deleteRequest(reqDocId, userId);
  }
}
