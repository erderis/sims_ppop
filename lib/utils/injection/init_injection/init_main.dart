import 'package:simsppob/features/main/presentation/cubit/navbar_cubit.dart';
import 'package:simsppob/utils/injection/injection_container.dart';

Future<void> initMain() async {
  //bloc
  sl.registerFactory(() => NavbarCubit());
}
