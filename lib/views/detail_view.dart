import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodies/bloc/food/food_bloc.dart';
import 'package:foodies/models/food_model.dart';
import 'package:foodies/utils/app_colors.dart';
import 'package:foodies/utils/app_core_widget.dart';
import 'package:go_router/go_router.dart';

class DetailView extends StatefulWidget {
  final FoodModel food;

  const DetailView({super.key, required this.food});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  FoodBloc bloc = FoodBloc();
  FoodModel? detail;

  _loadInit() {
    bloc.add(GetDetailFoodRequest(widget.food.idMeal ?? '-'));
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
          'Detail ${widget.food.strMeal ?? '-'}',
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
                    bloc: bloc,
                    listener: listenerDetail,
                    builder: builderDetail,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void listenerDetail(BuildContext context, Object? state) {
    if (state is GetDetailFoodSuccess) {
      detail = bloc.detailFood;
    }

    if (state is GetDetailFoodError) {
      Fluttertoast.showToast(msg: state.errorMessage ?? "Terjadi kesalahan");
    }
  }

  Widget builderDetail(BuildContext context, Object? state) {
    if (state is GetDetailFoodLoading) {
      return const Center(
        child: ThreeBounceLoading(
          size: 18,
          color: AppColors.color600,
        ),
      );
    }

    if (state is GetDetailFoodError) {
      return Container();
    }

    return buildDetail(context);
  }

  Widget buildDetail(BuildContext context) {
    final ingredients = detail?.ingredients ?? [];
    final measures = detail?.measures ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            detail?.strMealThumb ?? '',
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Center(
          child: Text(
            detail?.strMeal ?? '-',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          "Category: ${detail?.strCategory}",
          style: const TextStyle(fontSize: 12),
        ),
        Text(
          "Area: ${detail?.strArea}",
          style: const TextStyle(fontSize: 12),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Ingredients',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              '${ingredients.length} items',
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Column(
          children: List.generate(ingredients.length, (index) {
            final ingredient = ingredients[index] ?? '';
            final measure =
                index < measures.length ? measures[index] ?? '' : '';
            return Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                color: AppColors.color100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    ingredient,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    measure,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text(
          'Step',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(
          detail?.strInstructions ?? '-',
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}
