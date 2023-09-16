import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPasswordVisibilityCubit extends Cubit<bool> {
  RegisterPasswordVisibilityCubit() : super(false);
  void setVisibility(bool visibility) {
    emit(visibility);
  }
}
