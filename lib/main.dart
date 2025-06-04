import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodies/bloc/food/food_bloc.dart';
import 'package:foodies/models/food_model.dart';
import 'package:foodies/utils/app_colors.dart';
import 'package:foodies/views/category_view.dart';
import 'package:foodies/views/detail_view.dart';
import 'package:foodies/views/home_view.dart';
import 'package:foodies/views/splash_view.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => FoodBloc()),
      ],
      child: MaterialApp.router(
        title: 'Foodies',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.color600),
          primaryColor: AppColors.color600,
          textTheme: GoogleFonts.montserratTextTheme(),
          useMaterial3: true,
        ),
        routerConfig: _router,
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: '/category',
      builder: (context, state) {
        final food = state.extra as FoodModel;
        return CategoryView(food: food);
      },
    ),
    GoRoute(
      path: '/detail',
      builder: (context, state) {
        final food = state.extra as FoodModel;
        return DetailView(food: food);
      },
    ),
  ],
);
