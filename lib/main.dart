import 'package:audio_clock/db_audio/db_audio.dart';
import 'package:audio_clock/pages/add_clock/add_clock_binding.dart';
import 'package:audio_clock/pages/add_clock/add_clock_view.dart';
import 'package:audio_clock/pages/audio_list/audio_list_binding.dart';
import 'package:audio_clock/pages/audio_list/audio_list_view.dart';
import 'package:audio_clock/pages/audio_main/audio_main_binding.dart';
import 'package:audio_clock/pages/audio_main/audio_main_view.dart';
import 'package:audio_clock/pages/no_network/no_network_binding.dart';
import 'package:audio_clock/pages/no_network/no_network_view.dart';
import 'package:audio_clock/pages/remind/remind_binding.dart';
import 'package:audio_clock/pages/remind/remind_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Color primaryColor = const Color(0xff0634ff);
Color bgColor = const Color(0xffedeff3);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => DBAudio().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Audios
      ,
      initialRoute: '/audio_main',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        dialogTheme: const DialogTheme(
          actionsPadding: EdgeInsets.only(right: 10, bottom: 5),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}

List<GetPage<dynamic>> Audios = [
  GetPage(name: '/audio_main', page: () => const AudioMainPage(), binding: AudioMainBinding()),
  GetPage(name: '/restart', page: () => NoNetworkPage(), binding: NoNetworkBinding()),
  GetPage(name: '/audio_list', page: () => const AudioListPage(), binding: AudioListBinding()),
  GetPage(name: '/remind', page: () => RemindPage(), binding: RemindBinding()),
  GetPage(name: '/add_clock', page: () => AddClockPage(), binding: AddClockBinding()),
];
