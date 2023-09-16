import 'package:simsppob/core/response/response_model.dart';
import 'package:simsppob/features/home/domain/entities/banner_entity.dart';

class BannerResponseModel extends ResponseEntity {
  const BannerResponseModel(
      {required super.status, required super.message, required super.data});

  factory BannerResponseModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> jsonDataList = json['data'];
    final List<BannerModel> bannerList =
        jsonDataList.map((item) => BannerModel.fromJson(item)).toList();

    return BannerResponseModel(
      status: json['status'],
      message: json['message'],
      data: bannerList,
    );
  }
}

class BannerModel extends BannerEntity {
  const BannerModel(
      {required super.bannerName,
      required super.bannerImage,
      required super.description});

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      bannerName: json['banner_name'],
      bannerImage: json['banner_image'],
      description: json['description'],
    );
  }
}
