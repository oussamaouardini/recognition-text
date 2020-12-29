import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text_recognition_app/models/ScanResult.dart';


class ScanResultController extends GetxController {
  List<Map<String, dynamic>> scanListData = List<Map<String, dynamic>>.empty().obs;
  @override
  void onInit() {
    getResultScan();
    super.onInit();
  }

  Future<List<Map<String, dynamic>>>  getResultScan() async {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    List<Map<String, dynamic>> results =  await ScanResult.getAll();
    scanListData = results ;
    Get.back();
    return results;
  }

   void  deleteScan(int id) async {
    Future.delayed(
        Duration.zero,
            () => Get.dialog(Center(child: CircularProgressIndicator()),
            barrierDismissible: false));
    await ScanResult.delete(id);
    update();
    Get.back();
  }

  @override
  void onClose() {
    super.onClose();
  }
}