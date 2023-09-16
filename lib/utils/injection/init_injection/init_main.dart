import 'package:simsppob/features/home/presentation/provider/saldo_visibility_provider.dart';
import 'package:simsppob/features/main/presentation/provider/navbar_provider.dart';
import 'package:simsppob/utils/injection/injection_container.dart';

Future<void> initMain() async {
  //provider
  sl.registerFactory(() => SaldoVisibilityProvider());
  sl.registerFactory(() => NavbarProvider());
}
