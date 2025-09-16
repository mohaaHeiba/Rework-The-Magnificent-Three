import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:the_magnificent_three/controller/init_database.dart';
import 'package:the_magnificent_three/domain/entities/auth_entity.dart';

class AuthController extends GetxController {
  final contName = TextEditingController();
  final contEmail = TextEditingController();
  final contPhone = TextEditingController();
  final contEntry = TextEditingController();

  late final InitDatabase _db;
  final userData = Rx<AuthEntity?>(null);
  @override
  void onInit() {
    super.onInit();
    _db = Get.find<InitDatabase>();
    getUser();
  }

  Future<AuthEntity?> getUser() async {
    final data = await _db.userdata.authdao.getAuth();
    if (data != null) {
      userData.value = data;
      print(data.email);
      return data;
    } else {
      print("Error");
      return null;
    }
  }
}
