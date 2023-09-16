import 'package:simsppob/features/login/presentation/provider/login_password_visibility_provider.dart';
import 'package:simsppob/utils/injection/injection_container.dart';

Future<void> initLogin() async {
  //bloc
  // sl.registerFactory(() => LoginBloc());
  sl.registerFactory(() => LoginPasswordVisibilityProvider());
}
