import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simsppob/features/main/presentation/provider/navbar_provider.dart';

void onBackNavbar(BuildContext context) {
  context.read<NavbarProvider>().changeNavbar(0);
}
