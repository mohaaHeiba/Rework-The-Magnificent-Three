import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:the_magnificent_three/app.dart';
import 'package:the_magnificent_three/core/controller/init_database.dart';
import 'package:the_magnificent_three/core/side_navigation/controller/side_navigation_controll.dart';
import 'package:the_magnificent_three/presentation/controllers/auth/auth_controll.dart';
import 'package:the_magnificent_three/presentation/controllers/home/home_controll.dart';
import 'package:the_magnificent_three/presentation/controllers/splash/splash_controll.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Getstorage
  await GetStorage.init();
  // load Databse
  final init = Get.put(InitDatabase(), permanent: true);
  await init.initDatabase();

  Get.put(SplashControll(), permanent: true);
  Get.put(SidenavigationControll(), permanent: true);

  Get.put(AuthController(), permanent: true);
  Get.lazyPut(() => HomeControll());

  runApp(const MyApp());
}
