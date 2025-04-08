import 'package:get/get.dart';

import 'audio_list_logic.dart';

class AudioListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AudioListLogic());
  }
}
