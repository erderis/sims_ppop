import 'package:equatable/equatable.dart';

class ResponseEntity<T> extends Equatable {
  final int status;
  final String message;
  final T data;

  const ResponseEntity({
    required this.status,
    required this.message,
    required this.data,
  });

  @override
  List<Object?> get props => [status, message, data];
}
