import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodies/bloc/category/category_bloc.dart';
import 'package:foodies/bloc/food/food_bloc.dart';
import 'package:foodies/models/food_model.dart';
import 'package:foodies/utils/app_colors.dart';
import 'package:foodies/utils/app_core_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  FoodBloc bloc = FoodBloc();
  CategoryBloc categoryBloc = CategoryBloc();
  FoodModel? randomFood;
  List<FoodModel>? category;

  _loadInit() {
    bloc.add(GetRandomFoodRequest());
    categoryBloc.add(GetCategoryRequest());
  }

  @override
  void initState() {
    _loadInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(
                  top: 16, bottom: 16, left: 32, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome !',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  BlocConsumer(
                    bloc: bloc,
                    listener: listenerRandomFood,
                    builder: builderRandomFood,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Categories',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  BlocConsumer(
                    bloc: categoryBloc,
                    listener: listenerCategory,
                    builder: builderCategory,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void listenerRandomFood(BuildContext context, Object? state) {
    if (state is GetRandomFoodSuccess) {
      randomFood = bloc.randomFood;
    }

    if (state is GetRandomFoodError) {
      Fluttertoast.showToast(msg: state.errorMessage ?? "Terjadi kesalahan");
    }
  }

  Widget builderRandomFood(BuildContext context, Object? state) {
    if (state is GetRandomFoodLoading) {
      return const Center(
        child: ThreeBounceLoading(
          size: 18,
          color: AppColors.color600,
        ),
      );
    }

    if (state is GetRandomFoodError) {
      return Container();
    }

    return buildRandomFood(context);
  }

  Widget buildRandomFood(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
      decoration: BoxDecoration(
        color: AppColors.color100,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  randomFood?.strMeal ?? '-',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                ),
                Text(
                  randomFood?.strCategory ?? '-',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "@${randomFood?.strArea ?? '-'}",
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          if (randomFood?.strMealThumb != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                randomFood?.strMealThumb ?? '-',
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
        ],
      ),
    );
  }

  void listenerCategory(BuildContext context, Object? state) {
    if (state is GetCategorySuccess) {
      category = categoryBloc.category;
    }

    if (state is GetCategoryError) {
      Fluttertoast.showToast(msg: state.errorMessage ?? "Terjadi kesalahan");
    }
  }

  Widget builderCategory(BuildContext context, Object? state) {
    if (state is GetCategoryLoading) {
      return const Center(
        child: ThreeBounceLoading(
          size: 18,
          color: AppColors.color600,
        ),
      );
    }

    if (state is GetCategoryError) {
      return Container();
    }

    return buildCategory(context);
  }

  Widget buildCategory(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: category?.length,
        itemBuilder: (context, index) {
          final item = category?[index];
          return Container(
            width: 120,
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: AppColors.color600,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/${item?.strCategory}.png",
                  width: 40,
                  height: 40,
                  color: Colors.white,
                  errorBuilder: (_, __, ___) =>
                      const Icon(Icons.fastfood, color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  item?.strCategory ?? '-',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
