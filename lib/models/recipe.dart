class RecipeStep {
  final int num;
  final String title;
  final String text;
  final int timerSec;

  const RecipeStep({
    required this.num,
    required this.title,
    required this.text,
    this.timerSec = 0,
  });
}

class Recipe {
  final String id;
  final String title;
  final String subtitle;
  final String image;
  final String time;
  final String prepTime;
  final String cookTime;
  final String difficulty;
  final String rating;
  final int reviews;
  final int match;
  final String calories;
  final String protein;
  final String carbs;
  final String fat;
  final String category;
  final List<String> tags;
  final List<String> ingredients;
  final List<RecipeStep> steps;
  final String proTip;
  final String servings;

  const Recipe({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.time,
    required this.prepTime,
    required this.cookTime,
    required this.difficulty,
    required this.rating,
    required this.reviews,
    required this.match,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.category,
    required this.tags,
    required this.ingredients,
    required this.steps,
    required this.proTip,
    this.servings = '2 servings',
  });

  factory Recipe.fromGemini(
    Map<String, dynamic> data, {
    required String image,
  }) {
    final rawIngredients = data['ingredients'];
    final ingredients = rawIngredients is List
        ? rawIngredients
              .map((item) {
                if (item is Map) {
                  final quantity = item['quantity']?.toString().trim() ?? '';
                  final name = item['name']?.toString().trim() ?? '';
                  return [
                    quantity,
                    name,
                  ].where((part) => part.isNotEmpty).join(' ');
                }
                return item.toString().trim();
              })
              .where((item) => item.isNotEmpty)
              .toList()
        : <String>[];
    final rawSteps = data['steps'];
    final steps = rawSteps is List
        ? rawSteps
              .asMap()
              .entries
              .map((entry) {
                final item = entry.value;
                final map = item is Map ? item : <dynamic, dynamic>{};
                return RecipeStep(
                  num:
                      int.tryParse(map['number']?.toString() ?? '') ??
                      entry.key + 1,
                  title:
                      map['title']?.toString().trim() ??
                      'Step ${entry.key + 1}',
                  text:
                      map['instruction']?.toString().trim() ??
                      item.toString().trim(),
                  timerSec:
                      int.tryParse(
                        map['minutes']?.toString() ?? '',
                      )?.clamp(0, 86400) ??
                      0,
                );
              })
              .where((step) => step.text.isNotEmpty)
              .toList()
        : <RecipeStep>[];

    if (ingredients.isEmpty || steps.isEmpty) {
      throw const FormatException('Gemini returned an incomplete recipe.');
    }

    final time = data['cooking_time']?.toString().trim();
    return Recipe(
      id: 'gemini-${DateTime.now().millisecondsSinceEpoch}',
      title: data['name']?.toString().trim().isNotEmpty == true
          ? data['name'].toString().trim()
          : 'Gemini Kitchen Creation',
      subtitle:
          data['description']?.toString().trim() ??
          'A recipe created from your ingredients',
      image: image,
      time: time?.isNotEmpty == true ? time! : '30 min',
      prepTime: '10 min',
      cookTime: time?.isNotEmpty == true ? time! : '20 min',
      difficulty: data['difficulty']?.toString() ?? 'Easy',
      rating: '—',
      reviews: 0,
      match: 100,
      calories: data['calories']?.toString() ?? '—',
      protein: '—',
      carbs: '—',
      fat: '—',
      category: 'AI Generated',
      tags: const ['AI Generated'],
      ingredients: ingredients,
      steps: steps,
      proTip:
          data['tip']?.toString() ??
          'Taste and adjust seasoning before serving.',
      servings: data['servings']?.toString() ?? '2 servings',
    );
  }
}
