import 'package:get/get.dart';

import 'audio_main_logic.dart';

class AudioMainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AudioMainLogic());
  }
}
