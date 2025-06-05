import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodies/bloc/area/area_bloc.dart';
import 'package:foodies/bloc/category/category_bloc.dart';
import 'package:foodies/bloc/food/food_bloc.dart';
import 'package:foodies/models/food_model.dart';
import 'package:foodies/utils/app_colors.dart';
import 'package:foodies/utils/app_core_widget.dart';
import 'package:go_router/go_router.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  FoodBloc foodBloc = FoodBloc();
  CategoryBloc categoryBloc = CategoryBloc();
  AreaBloc areaBloc = AreaBloc();
  FoodModel? randomFood;
  List<FoodModel>? category;
  List<FoodModel>? area;

  final List<Color> colorVariants = [
    AppColors.color600,
    AppColors.color700,
    AppColors.color800,
    AppColors.color900,
  ];

  final List<Color> colorVariants2 = [
    AppColors.color900,
    AppColors.color800,
    AppColors.color700,
    AppColors.color600,
  ];

  _loadInit() {
    foodBloc.add(GetRandomFoodRequest());
    categoryBloc.add(GetCategoryRequest());
    areaBloc.add(GetAreaRequest());
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
                    bloc: foodBloc,
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
                        onPressed: () {
                          GoRouter.of(context).push('/category-list');
                        },
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
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Area',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          GoRouter.of(context).push('/area-list');
                        },
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
                    bloc: areaBloc,
                    listener: listenerArea,
                    builder: builderArea,
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
      randomFood = foodBloc.randomFood;
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
          final randomColor = colorVariants[index % colorVariants.length];

          return GestureDetector(
            onTap: () {
              GoRouter.of(context).push(
                '/category',
                extra: item,
              );
            },
            child: Container(
              width: 120,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: randomColor,
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
                  const SizedBox(
                    height: 8,
                  ),
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
            ),
          );
        },
      ),
    );
  }

  void listenerArea(BuildContext context, Object? state) {
    if (state is GetAreaSuccess) {
      area = areaBloc.area;
    }

    if (state is GetAreaError) {
      Fluttertoast.showToast(msg: state.errorMessage ?? "Terjadi kesalahan");
    }
  }

  Widget builderArea(BuildContext context, Object? state) {
    if (state is GetAreaLoading) {
      return const Center(
        child: ThreeBounceLoading(
          size: 18,
          color: AppColors.color600,
        ),
      );
    }

    if (state is GetAreaError) {
      return Container();
    }

    return buildArea(context);
  }

  Widget buildArea(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: area?.length,
        itemBuilder: (context, index) {
          final item = area?[index];
          final randomColor = colorVariants2[index % colorVariants2.length];
          String? countryCode = areaToCountryCode[item?.strArea];

          return GestureDetector(
            onTap: () {
              GoRouter.of(context).push(
                '/area',
                extra: item,
              );
            },
            child: Container(
              width: 120,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: randomColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (countryCode != null)
                    CountryFlag.fromCountryCode(
                      countryCode,
                      width: 32,
                      height: 20,
                    ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    item?.strArea ?? '-',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Map<String, String> areaToCountryCode = {
    'American': 'US',
    'British': 'GB',
    'Canadian': 'CA',
    'Chinese': 'CN',
    'Croatian': 'HR',
    'Dutch': 'NL',
    'Egyptian': 'EG',
    'Filipino': 'PH',
    'French': 'FR',
    'Greek': 'GR',
    'Indian': 'IN',
    'Irish': 'IE',
    'Italian': 'IT',
    'Jamaican': 'JM',
    'Japanese': 'JP',
    'Kenyan': 'KE',
    'Malaysian': 'MY',
    'Mexican': 'MX',
    'Moroccan': 'MA',
    'Polish': 'PL',
    'Portuguese': 'PT',
    'Russian': 'RU',
    'Spanish': 'ES',
    'Thai': 'TH',
    'Tunisian': 'TN',
    'Turkish': 'TR',
    'Ukrainian': 'UA',
    'Uruguayan': 'UY',
    'Vietnamese': 'VN',
  };
}
