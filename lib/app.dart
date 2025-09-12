import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'package:the_magnificent_three/platform/web/web_entry.dart';
import 'package:the_magnificent_three/platform/linux/linux_entry.dart';
import 'package:the_magnificent_three/platform/windows/win_entry.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Widget startPage;
    if (kIsWeb) {
      startPage = const WebEntry();
    } else if (Platform.isWindows) {
      startPage = const WinEntry();
    } else if (Platform.isLinux) {
      startPage = const LinuxEntry();
    } else {
      startPage = const LinuxEntry();
    }

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          brightness: Brightness.dark,
          primary: Colors.white,
          onPrimary: Colors.black,
          shadow: Color(0xFF2E7D9A),
          scrim: Color(0xFF1E5A73),
          inverseSurface: Color(0xFF0F3A4A),
          background: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.dark(
          brightness: Brightness.dark,
          primary: Colors.black,
          onPrimary: Colors.white,
          shadow: Colors.grey,
          scrim: Colors.black87,
          inverseSurface: Colors.black,
          background: Colors.grey[900],
        ),
      ),
      themeMode: ThemeMode.dark,
      home: startPage,
    );
  }
}
