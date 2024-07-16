import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ImagePickerProvider extends ChangeNotifier {
  final ImagePicker picker = ImagePicker();
  String? imagePath;
  final year = DateTime.now().year;
  String formattedDate = "";
  String formattedDateDi = "";
  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    imagePath = image!.path;
    notifyListeners();
  }

  Future<void> dateTimePickerDi(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(year + 1));
    if (pickedDate != null) {
      formattedDateDi = DateFormat('dd-MM-yyyy').format(pickedDate);
      notifyListeners();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Date is not seleted")));
      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> dateTimePicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(year + 1));
    if (pickedDate != null) {
      formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      notifyListeners();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Date is not seleted")));
      notifyListeners();
    }
    notifyListeners();
  }
}
