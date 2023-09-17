import 'package:flutter/material.dart';
import 'package:simsppob/core/widgets/app_dialog_loading.dart';

void showAppDialogLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const AppDialogLoading(),
  );
}
