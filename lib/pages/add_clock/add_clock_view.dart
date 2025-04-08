import 'package:audio_clock/main.dart';
import 'package:audio_clock/pages/add_clock/audio_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:styled_widget/styled_widget.dart';

import 'add_clock_logic.dart';

class AddClockPage extends GetView<AddClockLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Clock'),
        actions: [
          Text(
            'Save',
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold),
          ).marginOnly(right: 10).gestures(onTap: () {
            controller.addData();
          })
        ],
      ),
      body: GetBuilder<AddClockLogic>(builder: (_) {
        return SafeArea(
            child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(12),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: <Widget>[
              DateTimePickerWidget(
                dateFormat: 'HH:mm',
                pickerTheme: const DateTimePickerTheme(
                  confirm: SizedBox(),
                  cancel: SizedBox(),
                ),
                initDateTime: controller.clockTime,
                onChange: (dateTime, List index) {
                  controller.clockTime = dateTime;
                  controller.clockTimeString =
                      DateFormat('HH:mm').format(dateTime);
                  controller.update();
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      child: <Widget>[
                        <Widget>[
                          const Text('Week'),
                          SizedBox(
                            height: 24,
                            child: GridView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 1, mainAxisSpacing: 10),
                                itemCount: 7,
                                itemBuilder: (_, index) {
                                  return Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                          color: controller.weekDays
                                                  .contains(index + 1)
                                              ? Colors.white
                                              : Colors.grey),
                                    ),
                                  )
                                      .decorated(
                                          color: controller.weekDays
                                                  .contains(index + 1)
                                              ? primaryColor
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(12))
                                      .gestures(onTap: () {
                                    if (controller.weekDays
                                        .contains(index + 1)) {
                                      controller.weekDays.remove(index + 1);
                                    } else {
                                      controller.weekDays.add(index + 1);
                                    }
                                    controller.update();
                                  });
                                }),
                          )
                        ].toRow(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween),
                        Divider(
                          height: 25,
                          color: Colors.grey.shade300,
                        ),
                        SizedBox(
                          height: 35,
                          child: <Widget>[
                            const Text('Name'),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                                child: AudioTextField(
                                    maxLength: 20,
                                    value: controller.name,
                                    textAlign: TextAlign.end,
                                    onChange: (v) {
                                      controller.name = v;
                                    }))
                          ].toRow(),
                        ),
                        Divider(
                          height: 15,
                          color: Colors.grey.shade300,
                        ),
                        <Widget>[
                          const Text('Audio'),
                          Expanded(
                              child: Container(
                            height: 35,
                            color: Colors.transparent,
                            child: <Widget>[
                              Expanded(
                                  child: IgnorePointer(
                                child: AudioTextField(
                                    value: controller.audioEntity?.name ?? '',
                                    maxLength: 20,
                                    hintText: 'Please select audio',
                                    textAlign: TextAlign.end,
                                    onChange: (_) {}),
                              )),
                              const Icon(
                                Icons.keyboard_arrow_right,
                                size: 25,
                                color: Colors.grey,
                              )
                            ].toRow(),
                          ).gestures(onTap: (){
                                controller.showAudioList();
                              }))
                        ].toRow(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween),
                        Divider(
                          height: 15,
                          color: Colors.grey.shade300,
                        ),
                        <Widget>[
                          const Text('Remind'),
                          Switch(
                              value: controller.isRemind,
                              activeTrackColor: Colors.green,
                              onChanged: (v) {
                                controller.isRemind = v;
                                controller.update();
                              })
                        ].toRow(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween)
                      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start))
                  .decorated(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(12))
            ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
          ),
        ).decorated(color: Colors.white));
      }),
    );
  }
}
