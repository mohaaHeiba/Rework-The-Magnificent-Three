import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:the_magnificent_three/core/widgets/side_navigations.dart';

class InsertDataController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();

  final selectedRole = 'Doctor'.obs;
  final isSubmitting = false.obs;

  final Rx<File?> profileImageFile = Rx<File?>(null);
  final Rx<ImageProvider?> profileImageProvider = Rx<ImageProvider?>(null);

  final picker = ImagePicker();

  final List<String> userRoles = [
    'Doctor',
    'Radiologist',
    'Neurologist',
    'Technician',
  ];

  Future<void> pickProfileImage() async {
    if (kIsWeb) {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        final bytes = await image.readAsBytes();
        profileImageProvider.value = MemoryImage(bytes);
      }
    } else if (Platform.isWindows || Platform.isLinux) {
      final result = await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null && result.files.single.path != null) {
        profileImageFile.value = File(result.files.single.path!);
        profileImageProvider.value = FileImage(profileImageFile.value!);
      }
    } else {}
  }

  Future<void> submitUserData() async {
    if (!formKey.currentState!.validate()) return;

    isSubmitting.value = true;
    try {
      await Future.delayed(const Duration(seconds: 2));
      Get.snackbar(
        'Success',
        'Account created for ${fullNameController.text}!',
        backgroundColor: Colors.green,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
      resetForm();
      Get.to(SideNavigations(), transition: Transition.leftToRight);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to create account: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  void resetForm() {
    formKey.currentState?.reset();
    fullNameController.clear();
    emailController.clear();
    phoneController.clear();
    selectedRole.value = 'Doctor';
    profileImageFile.value = null;
    profileImageProvider.value = null;
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
