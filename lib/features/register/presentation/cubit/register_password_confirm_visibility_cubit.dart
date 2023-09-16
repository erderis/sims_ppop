import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPasswordConfirmVisibilityCubit extends Cubit<bool> {
  RegisterPasswordConfirmVisibilityCubit() : super(false);
  void setVisibility(bool visibility) {
    emit(visibility);
  }
}
