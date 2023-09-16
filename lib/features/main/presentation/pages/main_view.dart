import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:simsppob/constants/app_colors.dart';
import 'package:simsppob/features/account/presentation/pages/account_view.dart';
import 'package:simsppob/features/home/presentation/pages/home_view.dart';
import 'package:simsppob/features/main/presentation/cubit/navbar_cubit.dart';
import 'package:simsppob/features/topup/presentation/pages/topup_view.dart';
import 'package:simsppob/features/transaction/presentation/pages/transaction_view.dart';

class MainView extends StatelessWidget {
  MainView({super.key});

  final List<Widget> _views = [
    const HomeView(),
    const TopUpView(),
    const TransactionView(),
    const AccountView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BlocBuilder<NavbarCubit, int>(
        builder: (context, currentIndex) {
          return BottomNavigationBar(
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.textColor,
            selectedFontSize: 12.sp,
            unselectedFontSize: 12.sp,
            items: [
              _buildNavbarItem('Home', Icons.home),
              _buildNavbarItem('Top Up', Icons.money),
              _buildNavbarItem('Transaction', Icons.credit_card),
              _buildNavbarItem('Akun', Icons.person),
            ],
            onTap: (index) => context.read<NavbarCubit>().changeNavbar(index),
          );
        },
      ),
      body: BlocBuilder<NavbarCubit, int>(
        builder: (context, currentIndex) {
          return _views[currentIndex];
        },
      ),
    );
  }

  BottomNavigationBarItem _buildNavbarItem(String label, IconData icon) {
    return BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Icon(icon),
      ),
      label: label,
    );
  }
}
