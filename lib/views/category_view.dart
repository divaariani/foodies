import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodies/bloc/category/category_bloc.dart';
import 'package:foodies/models/food_model.dart';
import 'package:foodies/utils/app_colors.dart';
import 'package:foodies/utils/app_core_widget.dart';
import 'package:go_router/go_router.dart';

class CategoryView extends StatefulWidget {
  final FoodModel food;

  const CategoryView({super.key, required this.food});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  CategoryBloc categoryBloc = CategoryBloc();
  List<FoodModel>? list;
  Set<String> wishlist = {};

  _loadInit() {
    debugPrint("CEK FOOD: ${widget.food.strCategory}");
    categoryBloc.add(GetFoodCategoryRequest(widget.food.strCategory ?? '-'));
  }

  @override
  void initState() {
    _loadInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop();
          },
        ),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Food List - ${widget.food.strCategory ?? '-'}',
          style: const TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocConsumer(
                    bloc: categoryBloc,
                    listener: listenerList,
                    builder: builderList,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void listenerList(BuildContext context, Object? state) {
    if (state is GetFoodCategorySuccess) {
      list = categoryBloc.foodPerCategory;
    }

    if (state is GetFoodCategoryError) {
      Fluttertoast.showToast(msg: state.errorMessage ?? "Terjadi kesalahan");
    }
  }

  Widget builderList(BuildContext context, Object? state) {
    if (state is GetFoodCategoryLoading) {
      return const Center(
        child: ThreeBounceLoading(
          size: 18,
          color: AppColors.color600,
        ),
      );
    }

    if (state is GetFoodCategoryError) {
      return Container();
    }

    return buildList(context);
  }

  Widget buildList(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 3 / 3,
      ),
      itemCount: list?.length ?? 0,
      itemBuilder: (context, index) {
        final item = list![index];
        final isWishlisted = wishlist.contains(item.idMeal);

        return GestureDetector(
          onTap: () {
            GoRouter.of(context).push(
              '/detail',
              extra: item,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.color100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      child: Image.network(
                        item.strMealThumb ?? '',
                        width: double.infinity,
                        height: 100,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.broken_image),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isWishlisted) {
                              wishlist.remove(item.idMeal);
                            } else {
                              wishlist.add(item.idMeal!);
                            }
                          });
                        },
                        child: Icon(
                          isWishlisted ? Icons.favorite : Icons.favorite_border,
                          color: AppColors.color100,
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        (item.strMeal?.split(' ').length ?? 0) <= 3
                            ? item.strMeal ?? '-'
                            : "${item.strMeal?.split(' ').take(3).join(' ')}...",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
