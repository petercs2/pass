import 'package:audio_clock/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'audio_list_logic.dart';

class AudioListPage extends StatefulWidget {
  const AudioListPage({Key? key}) : super(key: key);

  @override
  State<AudioListPage> createState() => _AudioListPageState();
}

class _AudioListPageState extends State<AudioListPage> {
  AudioListLogic controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audio list'),
        foregroundColor: primaryColor,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(12),
        child: SafeArea(
            child: <Widget>[
              const Text(
                'My audio',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(child: Obx(() {
                return ListView.builder(
                    itemCount: controller.list.value.length + 1,
                    itemBuilder: (_, index) {
                      if (index == controller.list.value.length) {
                        return Container(
                          width: double.infinity,
                          height: 44,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: <Widget>[
                            Text('Custom audio',
                                style: TextStyle(color: primaryColor)),
                            const SizedBox(
                              width: 8,
                            ),
                            SvgPicture.asset(
                              'assets/img2.svg',
                              width: 25,
                              height: 25,
                              fit: BoxFit.cover,
                            )
                          ].toRow(mainAxisAlignment: MainAxisAlignment.center),
                        )
                            .decorated(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: primaryColor),
                        )
                            .gestures(onTap: () {
                              controller.pickAndUploadAudio();
                        });
                      }
                      final entity = controller.list.value[index];
                      return SwipeActionCell(
                          key: ObjectKey(entity.id),
                          backgroundColor: Colors.white,
                          trailingActions: <SwipeAction>[
                            SwipeAction(
                                title: "Delete",
                                onTap: (CompletionHandler handler) async {
                                  if (controller.isPlayingIndex == index) {
                                    controller.pauseAudio();
                                  }
                                  controller.deleteData(entity);
                                },
                                color: Colors.red),
                          ],
                          child: Container(
                            width: double.infinity,
                            height: 44,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(entity.name,style: TextStyle(color: primaryColor),),
                          ).decorated(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            border: Border.all(color: primaryColor),
                          ).marginOnly(bottom: 10).gestures(onTap: (){
                            if (controller.isPlayingIndex == index) {
                              if (controller.isPlaying) {
                                controller.pauseAudio();
                              } else {
                                controller.isPlayingIndex = index;
                                controller.playAudio(entity.audioPath);
                              }
                            } else {
                              controller.pauseAudio();
                              controller.isPlayingIndex = index;
                              controller.playAudio(entity.audioPath);
                            }

                          }));
                    });
              }))
            ].toColumn(crossAxisAlignment: CrossAxisAlignment.start)),
      ).decorated(color: Colors.white),
    );
  }
}

