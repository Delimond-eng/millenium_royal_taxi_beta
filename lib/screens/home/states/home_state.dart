import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeState extends GetxController {
  static HomeState instance = Get.find();

  var controller = PageController().obs;
  var pageIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    pageIndex.value = 0;
    controller.value = PageController(initialPage: 0);
  }

  void animateToNextPage(int page) {
    controller.value.animateToPage(page,
        duration: const Duration(milliseconds: 100), curve: Curves.easeIn);
    pageIndex.value = page;
  }

  void onPageChanged(int value) {
    pageIndex.value = value;
  }
}
