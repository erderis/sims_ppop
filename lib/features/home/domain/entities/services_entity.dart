import 'package:equatable/equatable.dart';

class ServiceEntity extends Equatable {
  final String serviceCode;
  final String serviceName;
  final String serviceIcon;
  final int serviceTariff;

  const ServiceEntity({
    required this.serviceCode,
    required this.serviceName,
    required this.serviceIcon,
    required this.serviceTariff,
  });

  @override
  List<Object?> get props =>
      [serviceCode, serviceName, serviceIcon, serviceTariff];
}
