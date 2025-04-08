import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'audio_main_logic.dart';

class AudioMainPage extends StatefulWidget {
  const AudioMainPage({Key? key}) : super(key: key);

  @override
  State<AudioMainPage> createState() => _AudioMainPageState();
}

class _AudioMainPageState extends State<AudioMainPage> {
  AudioMainLogic controller = Get.find();

  void checkNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      Get.toNamed('/restart');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    checkNetwork();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<AudioMainLogic>(builder: (_) {
        return SafeArea(
            bottom: false,
            child: <Widget>[
              <Widget>[
                <Widget>[
                  <Widget>[
                    SvgPicture.asset(
                      'assets/img0.svg',
                      width: 20,
                      height: 20,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      controller.isEdit ? 'Cancel' : 'Manager',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ].toRow().gestures(onTap: () {
                    controller.isEdit = !controller.isEdit;
                    controller.update();
                  }),
                  const SizedBox(
                    width: 10,
                  ),
                  <Widget>[
                    SvgPicture.asset(
                      'assets/img1.svg',
                      width: 20,
                      height: 20,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const Text(
                      'My audio',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )
                  ].toRow().gestures(onTap: () {
                    Get.toNamed('/audio_list');
                  })
                ].toRow(),
                SvgPicture.asset(
                  'assets/img2.svg',
                  width: 25,
                  height: 25,
                  fit: BoxFit.cover,
                ).gestures(onTap: () {
                  Get.toNamed('/add_clock')?.then((_) {
                    controller.getData();
                  });
                })
              ]
                  .toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween)
                  .marginSymmetric(horizontal: 15),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                  child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                child: <Widget>[
                  const Text(
                    'Random alarm clock',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Obx(() {
                      return controller.list.value.isEmpty
                          ? const Center(
                              child: Text('No data'),
                            )
                          : ListView.builder(
                              itemCount: controller.list.value.length,
                              itemBuilder: (_, index) {
                                final entity = controller.list.value[index];
                                return <Widget>[
                                  Image.asset('assets/icon${entity.bg}.png',
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.fill),
                                  <Widget>[
                                    Text(
                                      entity.name,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 20),
                                    ),
                                    <Widget>[
                                      Text(
                                        entity.clockTimeString,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontSize: 20),
                                      ),
                                      Switch(
                                          value:
                                              entity.remind == 1 ? true : false,
                                          activeTrackColor: Colors.green,
                                          onChanged: (v) async {
                                            final currentEntity = entity;
                                            currentEntity.remind =
                                                entity.remind == 1 ? 0 : 1;
                                            await controller.dbAudio
                                                .updateClockData(currentEntity);
                                            controller.getData();
                                          })
                                    ].toRow(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween),
                                    <Widget>[
                                      const Text(
                                        'Repeat',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      <Widget>[
                                        const Text(
                                          'Week',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          entity.repeat,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ].toRow()
                                    ].toRow(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween)
                                  ]
                                      .toColumn(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start)
                                      .marginSymmetric(
                                          horizontal: 40, vertical: 40),
                                  Visibility(
                                    visible: controller.isEdit,
                                    child: Positioned(
                                        top: 30,
                                        right: 30,
                                        child: const Icon(
                                          Icons.delete_forever,
                                          size: 25,
                                          color: Colors.black,
                                        ).gestures(onTap: () async {
                                          await controller.dbAudio
                                              .deleteClockData(entity.id);
                                          controller.getData();
                                        })),
                                  )
                                ].toStack();
                              });
                    }),
                  )
                ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
              ).decorated(color: Colors.white))
            ].toColumn());
      }),
    );
  }
}
