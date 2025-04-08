import 'package:get/get.dart';

import 'audio_tool_logic.dart';

class AudioToolBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      PageLogic(),
      permanent: true,
    );
  }
}
