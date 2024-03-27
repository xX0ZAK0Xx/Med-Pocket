import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:med_pocket/models/medicine_model.dart';

class MedicineController extends GetxController {
  RxList<dynamic> medicines = [].obs;

  final medicineBox = Hive.box('medicine');

  @override
  void onInit() {
    super.onInit();

    if (medicineBox.get('medicines') == null) {
      medicines.value = [];
    } else {
      medicines.value = medicineBox.get('medicines');
    }
  }

  void addMedicine(Medicine value) {
    medicines.add([value.type, value.name, value.time]);
    updateDatabase();
  }

  void deleteMedicine(int index) {
    medicines.removeAt(index);
    updateDatabase();
  }

  void editMedicine(int index, Medicine value) {
    medicines[index] = [value.type, value.name, value.time];
    updateDatabase();
  }

  void updateDatabase() {
    medicineBox.put('medicines', medicines);
  }
}
