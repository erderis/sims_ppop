import 'package:flutter/material.dart';
import 'package:simsppob/core/data_state/data_state.dart';
import 'package:simsppob/core/usecases/usecase.dart';
import 'package:simsppob/features/home/domain/entities/banner_entity.dart';
import 'package:simsppob/features/home/domain/usecases/get_banner_usecase.dart';
import 'package:simsppob/utils/helper/map_failure_to_message.dart';

class BannerProvider extends ChangeNotifier {
  final GetBannerUseCase getBannerUseCase;

  DataState<List<BannerEntity>> _dataState = DataState<List<BannerEntity>>();

  BannerProvider(this.getBannerUseCase);

  DataState<List<BannerEntity>> get dataState => _dataState;

  Future<void> getBanner() async {
    _dataState = DataState(isLoading: true);
    notifyListeners();

    final failureOrBanner = await getBannerUseCase(NoParams());
    failureOrBanner.fold(
        (failure) => _dataState =
            DataState(isError: true, error: mapFailureToMessage(failure)),
        (banner) => _dataState = DataState(isSuccess: true, data: banner));
    notifyListeners();
  }
}
