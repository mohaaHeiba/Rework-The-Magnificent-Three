import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:the_magnificent_three/presentation/navigationBar/side_navigations.dart';
import 'package:the_magnificent_three/presentation/pages/welcom_page.dart';

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
      theme: ThemeData(brightness: Brightness.light),

      //dark mode
      darkTheme: ThemeData(brightness: Brightness.dark),

      themeMode: ThemeMode.dark,
      //
      home: isDesktopOrWeb ? const WelcomPage() : const SideNavigations(),
    );
  }
}
