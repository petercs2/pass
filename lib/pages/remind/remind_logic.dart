import 'package:audio_clock/db_audio/audio_entity.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';

class RemindLogic extends GetxController {
  ClockEntity entity = Get.arguments;

  AudioPlayer audioPlayer = AudioPlayer();

  Future<void> playAudio(String filePath) async {
    await audioPlayer.play(DeviceFileSource(filePath));
  }

  @override
  void onInit() {
    // TODO: implement onInit
    Future.delayed(const Duration(seconds: 1), () {
      playAudio(entity.audioPath);
    });

    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    audioPlayer.dispose();
    super.onClose();
  }
}
