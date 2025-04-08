import 'dart:math';

import 'package:audio_clock/db_audio/audio_entity.dart';
import 'package:audio_clock/db_audio/db_audio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../main.dart';

class AddClockLogic extends GetxController {
  DBAudio dbAudio = Get.find();

  DateTime clockTime = DateTime.now();
  String clockTimeString = '';

  List<int> weekDays = [1, 2, 3, 4, 5, 6, 7];

  String name = '';

  AudioEntity? audioEntity;

  bool isRemind = true;

  void addData() async {
    if (name.isEmpty) {
      Fluttertoast.showToast(msg: 'Please enter the name');
      return;
    }
    if (audioEntity == null) {
      Fluttertoast.showToast(msg: 'Please select the audio');
      return;
    }
    if (weekDays.isEmpty) {
      Fluttertoast.showToast(msg: 'Please select the week days');
      return;
    }
    await dbAudio.insertClockData(ClockEntity(
        id: 0,
        createdTime: DateTime.now(),
        bg: Random().nextInt(4),
        name: name,
        clockTime: DateTime(clockTime.year, clockTime.month, clockTime.day,clockTime.hour,clockTime.minute,0),
        repeat: weekDays.join(','),
        audioName: audioEntity!.name,
        audioPath: audioEntity!.audioPath,
        remind: isRemind ? 1 : 0));
    Fluttertoast.showToast(msg: 'Added successfully');
    Get.back();
  }

  void showAudioList() async {
    final audioList = await dbAudio.getAudioAllData();
    if (audioList.isEmpty) {
      Fluttertoast.showToast(msg: 'No audio');
      return;
    }
    Get.bottomSheet(Container(
      width: double.infinity,
      height: 400,
      child: SafeArea(
        child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: audioList.length,
            itemBuilder: (_, index) {
              final entity = audioList[index];
              return Container(
                width: double.infinity,
                height: 44,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  entity.name,
                  style: TextStyle(color: primaryColor),
                ),
              )
                  .decorated(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    border: Border.all(color: primaryColor),
                  )
                  .marginOnly(bottom: 10).gestures(onTap: (){
                    audioEntity = entity;
                    Get.back();
                    update();
              });
            }),
      ),
    ).decorated(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12))));
  }
}
