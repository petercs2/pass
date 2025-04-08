import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'audio_tool_logic.dart';

class AudioToolView extends GetView<PageLogic> {
  const AudioToolView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => controller.legros.value
              ? const CircularProgressIndicator(color: Colors.black)
              : buildError(),
        ),
      ),
    );
  }

  Widget buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              controller.tsqg();
            },
            icon: const Icon(
              Icons.restart_alt,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}
