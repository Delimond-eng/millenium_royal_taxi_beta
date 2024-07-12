import 'package:get/get.dart';

class RideState extends GetxController {
  final RideState instance = Get.find();

  var userAgreement = false.obs;

  void allowAgreement() {
    userAgreement.value = !userAgreement.value;
  }
}
