import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text_recognition_app/models/ScanResult.dart';


class ScanResultController extends GetxController {
  List<Map<String, dynamic>> scanListData = List<Map<String, dynamic>>().obs;
  @override
  void onInit() {
    getResultScan();
    super.onInit();
  }

  void  getResultScan() async {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    List<Map<String, dynamic>> results =  await ScanResult(null,null).getAll();
    scanListData = results ;
    Get.back();
  }

  @override
  void onClose() {
    super.onClose();
  }
}