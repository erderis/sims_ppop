import 'package:simsppob/features/login/presentation/cubit/login_password_visibility_cubit.dart';
import 'package:simsppob/utils/injection/injection_container.dart';

Future<void> initLogin() async {
  //bloc
  // sl.registerFactory(() => LoginBloc());
  sl.registerFactory(() => LoginPasswordVisibilityCubit());
}
