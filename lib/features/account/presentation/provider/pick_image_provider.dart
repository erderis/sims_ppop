import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class PickImageProvider extends ChangeNotifier {
  String? _imagePath;

  String? get image => _imagePath;

  Future<void> pickImageFromGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['jpeg', 'png'],
    );
    if (result != null) {
      _imagePath = result.files.first.path;
      notifyListeners();
    }
  }
}
