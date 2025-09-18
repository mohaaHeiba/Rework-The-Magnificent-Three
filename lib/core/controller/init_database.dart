import 'dart:io';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:the_magnificent_three/data/datasources/auth_databases.dart';
import 'package:the_magnificent_three/data/datasources/patient_dao.dart';

class InitDatabase extends GetxController {
  late final UserDatabase userdata;
  late final UserDatabase patientDatabase;
  late final PatientDao patientdao;

  Future<void> initDatabase() async {
    try {
      // Initialize auth database
      await _copyDatabase();
      final dir = await getApplicationDocumentsDirectory();
      final authDbPath = join(dir.path, 'data.db');
      userdata = await $FloorUserDatabase.databaseBuilder(authDbPath).build();

      // Initialize patient database
      final patientDbPath = join(dir.path, 'patient_database.db');
      patientDatabase = await $FloorUserDatabase
          .databaseBuilder(patientDbPath)
          .build();
      patientdao = patientDatabase.patientdoa;

      // Make PatientDao available for dependency injection
      Get.put<PatientDao>(patientdao, permanent: true);
    } catch (e) {
      print('Database initialization error: $e');
      rethrow;
    }
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
