import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPasswordVisibilityCubit extends Cubit<bool> {
  LoginPasswordVisibilityCubit() : super(false);
  void setVisibility(bool visibility) {
    emit(visibility);
  }
}
