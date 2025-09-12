import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:the_magnificent_three/core/widgets/side_navigations.dart';
import 'package:the_magnificent_three/core/widgets/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Platform chanels
    final bool isDesktopOrWeb =
        kIsWeb || Platform.isWindows || Platform.isLinux;

    return GetMaterialApp(
      //theme

      //light mode
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          brightness: Brightness.dark,
          primary: Colors.white,
          onPrimary: Colors.black,

          //gredinat
          shadow: const Color(0xFF2E7D9A),
          scrim: const Color(0xFF1E5A73),
          inverseSurface: const Color(0xFF0F3A4A),
          //
          background: Colors.white,
        ),
      ),

      //dark mode
      darkTheme: ThemeData(
        colorScheme: ColorScheme.dark(
          brightness: Brightness.dark,
          primary: Colors.black,
          onPrimary: Colors.white,
          //gredinat
          shadow: Colors.grey[800],
          scrim: Colors.grey[900],
          inverseSurface: Colors.black,
          //
          background: Colors.grey[900],
        ),
      ),

      themeMode: ThemeMode.dark,
      //
      home: isDesktopOrWeb ? const SplashScreen() : const SideNavigations(),
    );
  }
}
