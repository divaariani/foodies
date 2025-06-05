import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodies/bloc/category/category_bloc.dart';
import 'package:foodies/models/food_model.dart';
import 'package:foodies/utils/app_colors.dart';
import 'package:foodies/utils/app_core_widget.dart';
import 'package:go_router/go_router.dart';

class CategoryListView extends StatefulWidget {
  const CategoryListView({super.key});

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  CategoryBloc categoryBloc = CategoryBloc();
  List<FoodModel>? category;

  final List<Color> colorVariants = [
    AppColors.color600,
    AppColors.color700,
    AppColors.color800,
    AppColors.color900,
  ];

  _loadInit() {
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
        title: const Text(
          'Categories',
          style: TextStyle(
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
              padding: const EdgeInsets.only(
                  top: 16, bottom: 16, left: 32, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 3 / 3,
      ),
      itemCount: category?.length ?? 0,
      itemBuilder: (context, index) {
        final item = category![index];
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
                    "assets/${item.strCategory}.png",
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
                    item.strCategory ?? '-',
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
    );
  }
}
