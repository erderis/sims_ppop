import 'package:simsppob/core/response/response_model.dart';
import 'package:simsppob/features/home/domain/entities/services_entity.dart';

class ServicesResponseModel extends ResponseEntity {
  const ServicesResponseModel(
      {required super.status, required super.message, required super.data});

  factory ServicesResponseModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> jsonDataList = json['data'];
    final List<ServicesModel> serviceList =
        jsonDataList.map((item) => ServicesModel.fromJson(item)).toList();
    return ServicesResponseModel(
      status: json['status'],
      message: json['message'],
      data: serviceList,
    );
  }
}

class ServicesModel extends ServiceEntity {
  const ServicesModel(
      {required super.serviceCode,
      required super.serviceName,
      required super.serviceIcon,
      required super.serviceTariff});

  factory ServicesModel.fromJson(Map<String, dynamic> json) {
    return ServicesModel(
      serviceCode: json['service_code'],
      serviceName: json['service_name'],
      serviceIcon: json['service_icon'],
      serviceTariff: json['service_tariff'],
    );
  }
}
