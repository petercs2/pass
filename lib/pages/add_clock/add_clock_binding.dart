import 'package:get/get.dart';

import 'add_clock_logic.dart';

class AddClockBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddClockLogic());
  }
}
