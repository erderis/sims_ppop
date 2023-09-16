import 'package:equatable/equatable.dart';

class BannerEntity extends Equatable {
  final String bannerName;
  final String bannerImage;
  final String description;

  const BannerEntity({
    required this.bannerName,
    required this.bannerImage,
    required this.description,
  });

  @override
  List<Object?> get props => [bannerName, bannerImage, description];
}
