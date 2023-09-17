import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:simsppob/config/app_routes.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/constants/app_padding.dart';
import 'package:simsppob/constants/app_text_style.dart';
import 'package:simsppob/core/widgets/app_shimmer.dart';
import 'package:simsppob/features/home/domain/entities/services_entity.dart';
import 'package:simsppob/features/home/presentation/provider/services_provider.dart';

class HomeServicesView extends StatelessWidget {
  const HomeServicesView({
    super.key,
  });

  void onClickItem(BuildContext context, {required ServiceEntity data}) {
    Navigator.pushNamed(context, Routes.payment, arguments: {'service': data});
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ServicesProvider>(builder: (context, provider, _) {
      if (provider.dataState.isLoading) {
        return Padding(
          padding:
              EdgeInsets.symmetric(horizontal: AppPadding.horizontalPaddingXL),
          child: const AppShimmer(
            width: double.infinity,
            height: 100,
          ),
        );
      } else if (provider.dataState.isSuccess) {
        final data = provider.dataState.data!;
        return Wrap(
          alignment: WrapAlignment.center,
          spacing: 10.w,
          runSpacing: 20.w,
          children: List.generate(
              data.length,
              (index) => Column(
                    children: [
                      InkWell(
                        onTap: () => onClickItem(context, data: data[index]),
                        child: Container(
                          width: 48.w,
                          height: 48.w,
                          decoration: BoxDecoration(
                              color: AppColors.borderColor,
                              image: DecorationImage(
                                  image: NetworkImage(data[index].serviceIcon)),
                              borderRadius:
                                  BorderRadius.circular(AppPadding.radius)),
                        ),
                      ),
                      SizedBox(
                        height: AppPadding.verticalPaddingS,
                      ),
                      InkWell(
                        onTap: () => onClickItem(context, data: data[index]),
                        child: SizedBox(
                          width: 48.w,
                          child: Text(
                            data[index].serviceName.replaceAll(' ', '\n'),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.subDescriptionTextStyle
                                .copyWith(fontWeight: FontWeight.w500),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  )),
        );
      } else if (provider.dataState.isError) {
        return Center(
          child: Text(
            provider.dataState.error!,
            style: AppTextStyles.descriptionTextStyle,
          ),
        );
      }
      return const SizedBox();
    });
  }
}
