import 'package:simsppob/features/main/presentation/provider/navbar_provider.dart';
import 'package:simsppob/utils/injection/injection_container.dart';

Future<void> initInjectionMain() async {
  //provider
  sl.registerFactory(() => NavbarProvider());
}
