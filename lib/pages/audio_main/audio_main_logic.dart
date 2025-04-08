import 'dart:async';

import 'package:audio_clock/db_audio/audio_entity.dart';
import 'package:audio_clock/db_audio/db_audio.dart';
import 'package:get/get.dart';

class AudioMainLogic extends GetxController {
  DBAudio dbAudio = Get.find();

  bool isEdit = false;

  Timer? _timer;

  var list = <ClockEntity>[].obs;

  void startTimer() {
    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      for (var item in list) {
        List weekdays =
            item.repeat.split(',').map((e) => int.parse(e)).toList();
        if (item.clockTime.hour == now.hour &&
            item.clockTime.minute == now.minute &&
            item.clockTime.second == now.second &&
            item.remind == 1 &&
            (weekdays.contains(DateTime.now().weekday))) {
          Get.toNamed('/remind', arguments: item);
        }
      }
    });
  }

  void getData() async {
    list.value = await dbAudio.getClockAllData();
    startTimer();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }
}
