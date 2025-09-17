import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:the_magnificent_three/core/controller/init_database.dart';
import 'package:the_magnificent_three/domain/entities/auth_entity.dart';

class AuthController extends GetxController {
  final contName = TextEditingController();
  final contEmail = TextEditingController();
  final contPass = TextEditingController();
  final contEntry = TextEditingController();

  final selectedRole = 'Doctor'.obs;

  final List<String> entries = [
    'Doctor',
    'Radiologist',
    'Neurologist',
    'Technician',
  ];

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late final InitDatabase _db;
  final userData = Rx<AuthEntity?>(null);

  @override
  void onInit() {
    super.onInit();
    _db = Get.find<InitDatabase>();
  }

  Future<AuthEntity?> getUser() async {
    final data = await _db.userdata.authdao.getAuth();
    if (data != null) {
      userData.value = data;
      return data;
    } else {
      return null;
    }
  }

  Future<int?> inserUser() async {
    try {
      final id = await _db.userdata.authdao.insertAuth(
        AuthEntity(
          1,
          name: contName.text,
          email: contEmail.text,
          pass: contPass.text,
        ),
      );

      if (id != null) {
        print('✅ Success, inserted with id: $id');
      } else {
        print('⚠️ Failed to insert');
      }

      return id;
    } catch (e) {
      print('❌ Error inserting user: $e');
      return null;
    }
  }

  Future<AuthEntity?> updateUser() async {
    try {
      final data = await _db.userdata.authdao.updatetAuth(
        AuthEntity(
          1,
          name: contName.text,
          email: contEmail.text,
          pass: contPass.text,
        ),
      );

      if (data != null) {
        print('Suscess');
      } else {
        print("Faild");
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> deleteUser() async {
    if (userData.value != null) {
      await _db.userdata.authdao.deleteAuth(userData.value!);
      userData.value = null;
      print("Success");
    } else {
      print("Error");
    }
  }
}
