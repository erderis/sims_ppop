import 'package:simsppob/features/register/presentation/cubit/register_password_confirm_visibility_cubit.dart';
import 'package:simsppob/features/register/presentation/cubit/register_password_visibility_cubit.dart';
import 'package:simsppob/utils/injection/injection_container.dart';

Future<void> initRegister() async {
  //bloc
  // sl.registerFactory(() => LoginBloc());
  sl.registerFactory(() => RegisterPasswordVisibilityCubit());
  sl.registerFactory(() => RegisterPasswordConfirmVisibilityCubit());
}
