import 'package:get/get.dart';

import 'remind_logic.dart';

class RemindBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RemindLogic());
  }
}
