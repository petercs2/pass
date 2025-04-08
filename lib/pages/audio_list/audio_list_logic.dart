import 'dart:io';

import 'package:audio_clock/db_audio/audio_entity.dart';
import 'package:audio_clock/db_audio/db_audio.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AudioListLogic extends GetxController {

  DBAudio dbAudio = Get.find();

  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  int isPlayingIndex = 0;
  bool isPicking = false;

  var list = <AudioEntity>[].obs;

  Future<void> pickAndUploadAudio() async {
    if (await Permission.storage.request().isGranted) {
      try {
        FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['mp3', 'wav', 'aac'],
        );

        if (result != null) {
          PlatformFile file = result.files.single;
          File localFile = File(file.path!);

          final appDir = await getApplicationDocumentsDirectory();
          String newPath = '${appDir.path}/${file.name}';
          File savedFile = await localFile.copy(newPath);
          final filePath = savedFile.path;
          final fileName = file.name;
          try {
            AudioEntity audioEntity = AudioEntity(
              id: 0,
              createdTime: DateTime.now(),
              name: fileName,
              audioPath: filePath,
            );
            await dbAudio.insertAudioData(audioEntity);
            Fluttertoast.showToast(msg: "File uploaded successfully");
            getData();
          } catch (e) {
            Fluttertoast.showToast(msg: "File upload error: $e");
          }
        }
      } catch (e) {
        Fluttertoast.showToast(msg: "File selection error: $e");
      } finally {
        isPicking = false;
      }
    }
  }

  Future<void> playAudio(String filePath) async {
    await audioPlayer.play(DeviceFileSource(filePath));
    isPlaying = true;
  }

  Future<void> pauseAudio() async {
    await audioPlayer.stop();
    isPlaying = false;
    isPlayingIndex = 0;
  }

  void getData() async {
    list.value = await dbAudio.getAudioAllData();
  }

  deleteData(AudioEntity entity) async {
    await dbAudio.deleteAudioData(entity.id);
    getData();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    audioPlayer.dispose();
    super.onClose();
  }

}
