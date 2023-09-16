import 'package:simsppob/core/error/error_response.dart';

class ServerException implements Exception {
  final ErrorResponse? errorResponse;

  ServerException({this.errorResponse});
}

class CacheException implements Exception {}

class DeviceInfoException implements Exception {}

class LocationServiceException implements Exception {}

class LocationPermissionException implements Exception {}
