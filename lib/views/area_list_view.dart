import 'package:flutter/material.dart';
import 'package:country_flags/country_flags.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodies/bloc/area/area_bloc.dart';
import 'package:foodies/models/food_model.dart';
import 'package:foodies/utils/app_colors.dart';
import 'package:foodies/utils/app_core_widget.dart';
import 'package:go_router/go_router.dart';

class AreaListView extends StatefulWidget {
  const AreaListView({super.key});

  @override
  State<AreaListView> createState() => _AreaListViewState();
}

class _AreaListViewState extends State<AreaListView> {
  AreaBloc areaBloc = AreaBloc();
  List<FoodModel>? area;

  final List<Color> colorVariants = [
    AppColors.color900,
    AppColors.color800,
    AppColors.color700,
    AppColors.color600,
  ];

  _loadInit() {
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
          'Areas',
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
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 3 / 3,
      ),
      itemCount: area?.length ?? 0,
      itemBuilder: (context, index) {
        final item = area![index];
        final randomColor = colorVariants[index % colorVariants.length];
        String? countryCode = areaToCountryCode[item.strArea];

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
                  item.strArea ?? '-',
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
