import 'package:equatable/equatable.dart';
import 'package:simsppob/core/error/error_response.dart';

abstract class Failure extends Equatable {
  // Failure([List properties = const <dynamic>[]]) : super();
}

class ServerFailure extends Failure {
  final ErrorResponse? errorResponse;

  ServerFailure({this.errorResponse});
  @override
  List<Object?> get props => [errorResponse];
}

class CacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class NetworkFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class DeviceInfoFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class RootFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class LocationFailure extends Failure {
  @override
  List<Object?> get props => [];
}
