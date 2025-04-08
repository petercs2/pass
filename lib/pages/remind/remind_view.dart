import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'remind_logic.dart';

class RemindPage extends GetView<RemindLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      child: <Widget>[
        Text(
          controller.entity.clockTimeString,
          style: const TextStyle(
              fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        Text(controller.entity.name,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
        const SizedBox(
          height: 260,
        ),
        Container(
          width: 200,
          height: 50,
          alignment: Alignment.center,
          child: const Text(
            'Done',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
            .decorated(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.white))
            .gestures(onTap: () {
          Get.back();
        })
      ].toColumn(mainAxisAlignment: MainAxisAlignment.center),
    ).decorated(
            image: DecorationImage(
                image: AssetImage(
                    'assets/${controller.entity.clockTime.isAfter(DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 18)) ? 'dark' : 'light'}.png'),
                fit: BoxFit.fill)));
  }
}
