import 'package:flutter/material.dart';
import 'package:simsppob/core/data_state/data_state.dart';
import 'package:simsppob/core/usecases/usecase.dart';
import 'package:simsppob/features/home/domain/entities/services_entity.dart';
import 'package:simsppob/features/home/domain/usecases/get_services_usecase.dart';
import 'package:simsppob/utils/helper/map_failure_to_message.dart';

class ServicesProvider extends ChangeNotifier {
  final GetServicesUseCase getServicesUseCase;

  DataState<List<ServiceEntity>> _dataState = DataState<List<ServiceEntity>>();

  ServicesProvider(this.getServicesUseCase);

  DataState<List<ServiceEntity>> get dataState => _dataState;

  Future<void> getServices({bool isWithLoading = true}) async {
    if (isWithLoading) {
      _dataState = DataState(isLoading: true);
    }
    notifyListeners();

    final failureOrServices = await getServicesUseCase(NoParams());
    failureOrServices.fold(
        (failure) => _dataState =
            DataState(isError: true, error: mapFailureToMessage(failure)),
        (services) => _dataState = DataState(isSuccess: true, data: services));
    notifyListeners();
  }
}
