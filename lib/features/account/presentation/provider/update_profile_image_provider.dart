import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simsppob/core/data_state/data_state.dart';
import 'package:simsppob/features/account/domain/entities/profile_entity.dart';
import 'package:simsppob/features/account/domain/usecases/update_profile_image_usecase.dart';
import 'package:simsppob/utils/helper/map_failure_to_message.dart';
import 'package:simsppob/utils/helper/show_app_toast.dart';

class UpdateProfileImageProvider extends ChangeNotifier {
  final UpdateProfileImageUseCase updateProfileImageUseCase;

  DataState<ProfileEntity> _dataState = DataState<ProfileEntity>();

  UpdateProfileImageProvider(this.updateProfileImageUseCase);

  DataState<ProfileEntity> get dataState => _dataState;

  void pickImage(BuildContext context) {
    final ImagePicker picker = ImagePicker();
    picker.pickImage(source: ImageSource.gallery).then((image) {
      if (image != null) {
        final File imageFile = File(image.path);
        final String fileExtension = image.path.split('.').last.toLowerCase();

        if (fileExtension == 'jpg' ||
            fileExtension == 'jpeg' ||
            fileExtension == 'png') {}

        imageFile.length().then((fileSizeInBytes) {
          if (fileSizeInBytes <= 100 * 1024) {
          } else {
            showAppToast(context,
                message: 'Ukuran maksimal gambar adalah 100kb');
          }
        });
      } else {
        showAppToast(context,
            message: 'Hanya file JPG, JPEG dan PNG yang diterima');
      }
    });
  }

  Future<void> updateProfileImage(String filePath) async {
    _dataState = DataState(isLoading: true);
    notifyListeners();
    final failureOrProfile = await updateProfileImageUseCase(filePath);
    failureOrProfile.fold(
        (failure) => _dataState =
            DataState(isError: true, error: mapFailureToMessage(failure)),
        (profile) => _dataState = DataState(isSuccess: true, data: profile));
    notifyListeners();
  }
}
