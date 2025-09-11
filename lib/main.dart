import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:get/get.dart';
import 'dart:io' show Platform;

import 'package:the_magnificent_three/presentation/controllers/welcome_caontroll.dart';
import 'package:the_magnificent_three/presentation/pages/home/home_page.dart';
import 'package:the_magnificent_three/presentation/pages/welcom_page.dart';

void main() async {
  Get.put(WelcomeCaontroll());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDesktopOrWeb =
        kIsWeb || Platform.isWindows || Platform.isLinux;

    return GetMaterialApp(
      home: isDesktopOrWeb ? const WelcomPage() : const HomePage(),
    );
  }
}
