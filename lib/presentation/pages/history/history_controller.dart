import 'package:get/get.dart';
import 'package:the_magnificent_three/data/datasources/patient_dao.dart';
import 'package:the_magnificent_three/domain/entities/patient_entity.dart';

class HistoryController extends GetxController {
  final PatientDao patientDao;
  final RxList<PatientEntity> patients = <PatientEntity>[].obs;
  final isLoading = true.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;

  HistoryController({required this.patientDao});

  @override
  void onInit() {
    super.onInit();
    loadPatients();
  }

  @override
  void onReady() {
    super.onReady();
    // Refresh data when page becomes ready
    loadPatients();
  }

  Future<void> loadPatients() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      errorMessage.value = '';

      final data = await patientDao.getPatients();
      patients.value = data;
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Error loading patients: $e';
      print('Error loading patients: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Add method to manually refresh
  Future<void> refreshPatients() async {
    await loadPatients();
  }

  Future<void> deletePatient(PatientEntity patient) async {
    try {
      await patientDao.deletePatients(patient);
      patients.remove(patient);
      Get.back(); // Close dialog
      Get.snackbar(
        'Success',
        'Patient record deleted successfully',
        snackPosition: SnackPosition.TOP,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete patient record: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
