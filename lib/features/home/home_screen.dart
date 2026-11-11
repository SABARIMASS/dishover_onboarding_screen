import 'package:flutter/material.dart';
import 'package:onboarding_screen/core/constants/app_colors.dart';
import 'package:onboarding_screen/core/constants/app_strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        backgroundColor: AppColors.kPrimaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'Welcome to Dishover!',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}

