import 'package:flutter/material.dart';
import 'package:foodies/utils/app_colors.dart';
import 'package:foodies/views/splash_view.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Foodies',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.color600),
        primaryColor: AppColors.color600,
        textTheme: GoogleFonts.montserratTextTheme(),
        useMaterial3: true,
      ),
      home: const SplashView(),
    );
  }
}
