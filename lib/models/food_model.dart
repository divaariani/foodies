class FoodModel {
  final String? idMeal;
  final String? strMeal;
  final String? strMealAlternate;
  final String? strCategory;
  final String? strArea;
  final String? strInstructions;
  final String? strMealThumb;
  final String? strTags;
  final String? strYoutube;
  final List<String?> ingredients;
  final List<String?> measures;
  final String? strSource;

  FoodModel({
    this.idMeal,
    this.strMeal,
    this.strMealAlternate,
    this.strCategory,
    this.strArea,
    this.strInstructions,
    this.strMealThumb,
    this.strTags,
    this.strYoutube,
    required this.ingredients,
    required this.measures,
    this.strSource,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    List<String?> ingredients = List.generate(
      20,
      (index) => json['strIngredient${index + 1}'] as String?,
    ).where((item) => item != null && item.isNotEmpty).toList();

    List<String?> measures = List.generate(
      20,
      (index) => json['strMeasure${index + 1}'] as String?,
    ).where((item) => item != null && item.isNotEmpty).toList();

    return FoodModel(
      idMeal: json['idMeal'] as String?,
      strMeal: json['strMeal'] as String?,
      strMealAlternate: json['strMealAlternate'] as String?,
      strCategory: json['strCategory'] as String?,
      strArea: json['strArea'] as String?,
      strInstructions: json['strInstructions'] as String?,
      strMealThumb: json['strMealThumb'] as String?,
      strTags: json['strTags'] as String?,
      strYoutube: json['strYoutube'] as String?,
      ingredients: ingredients,
      measures: measures,
      strSource: json['strSource'] as String?,
    );
  }
}
