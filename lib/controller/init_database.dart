import 'dart:io';

import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:the_magnificent_three/data/datasources/auth_databases.dart';

class InitDatabase extends GetxController {
  late final UserDatabase userdata;

  Future<void> initDatabase() async {
    await _copyDatabase();
    final dir = await getApplicationDocumentsDirectory();
    final dbPath = join(dir.path, 'data.db');

    userdata = await $FloorUserDatabase.databaseBuilder(dbPath).build();
  }

  Future<void> _copyDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, 'data.db');

    if (File(path).existsSync()) return;

    ByteData data = await rootBundle.load('assets/data/data.db');
    final bytes = data.buffer.asUint8List(
      data.offsetInBytes,
      data.lengthInBytes,
    );
    await File(path).writeAsBytes(bytes);
  }
}
