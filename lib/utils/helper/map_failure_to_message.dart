import 'package:simsppob/constants/error.dart';
import 'package:simsppob/core/error/failure.dart';

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      if ((failure as ServerFailure).errorResponse != null) {
        return (failure).errorResponse!.message;
      } else {
        return serverFailureMessage;
      }
    case CacheFailure:
      return cacheFailureMessage;
    case NetworkFailure:
      return networkFailureMessage;
    default:
      return 'Unexpected Error';
  }
}
