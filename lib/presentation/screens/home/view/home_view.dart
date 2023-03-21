import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:islamic_app/presentation/resources/strings_manager.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items:  [
          BottomNavigationBarItem(icon: const Icon(Icons.home), label: AppStrings.home.tr(),),
          BottomNavigationBarItem(icon: const Icon(Icons.settings), label: AppStrings.settings.tr(),),
          BottomNavigationBarItem(icon: const Icon(Icons.person), label: AppStrings.profile.tr(),),
        ],
      ),
      body: Center(
        child: Text(AppStrings.home.tr()),
      ),
    );
  }
}
