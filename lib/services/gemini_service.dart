import 'dart:convert';

import 'package:google_generative_ai/google_generative_ai.dart';
import '../models/recipe.dart';

/// Thin client for Gemini.
///
/// Pass the key at build/run time instead of committing it to source control:
/// `flutter run --dart-define=GEMINI_API_KEY=...`.
class GeminiService {
 // GeminiService({String? apiKey, String model = 'gemini-1.5-flash'})
  GeminiService({String? apiKey, String model = 'gemini-3.6-flash'})
    : _apiKey = apiKey ?? const String.fromEnvironment('GEMINI_API_KEY'),
      _modelName = model;

  final String _apiKey;
  final String _modelName;

  bool get isConfigured => _apiKey.trim().isNotEmpty;

  GenerativeModel? get _model =>
      isConfigured ? GenerativeModel(model: _modelName, apiKey: _apiKey) : null;

  /// Returns Gemini's response, or a clear configuration error.
  Future<String> generateText(String prompt) async {
    final model = _model;
    if (model == null) {
      throw StateError(
        'Gemini is not configured. Set GEMINI_API_KEY with --dart-define.',
      );
    }

    final response = await model.generateContent([Content.text(prompt)]);
    final text = response.text?.trim();
    if (text == null || text.isEmpty) {
      throw StateError('Gemini returned an empty response.');
    }
    return text;
  }

  Future<String> suggestRecipesFromIngredients(Iterable<String> ingredients) {
    final list = ingredients
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .join(', ');
    return generateText(
      'Suggest three practical recipes using these ingredients: $list. '
      'For each, provide a title, short description, and numbered steps.',
    );
  }

  Future<Recipe> generateRecipeFromIngredients(
    Iterable<String> ingredients, {
    String dietaryGoal = 'balanced',
    String maxCookingTime = 'any time',
    required String fallbackImage,
  }) async {
    final list = ingredients
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .join(', ');
    final response = await generateText('''
Create one unique, practical recipe using these ingredients: $list.
Dietary preference: $dietaryGoal. Maximum cooking time: $maxCookingTime.
You may add ordinary pantry staples, but prioritize the supplied ingredients.
Return ONLY valid JSON matching this exact shape:
{
  "name": "recipe name",
  "description": "one sentence",
  "cooking_time": "25 min",
  "servings": "2 servings",
  "difficulty": "Easy",
  "calories": "450 kcal",
  "tip": "one useful chef tip",
  "ingredients": [{"quantity": "2", "name": "eggs"}],
  "steps": [{"number": 1, "title": "Prep", "instruction": "...", "minutes": 5}]
}
Include measured quantities for every ingredient and 3-8 numbered steps.
''');

    try {
      // Robust JSON extraction in case Gemini includes markdown fences
      String cleanJson = response;
      if (cleanJson.contains('```')) {
        final start = cleanJson.indexOf('{');
        final end = cleanJson.lastIndexOf('}');
        if (start != -1 && end != -1 && end > start) {
          cleanJson = cleanJson.substring(start, end + 1);
        }
      }

      final decoded = jsonDecode(cleanJson);
      if (decoded is! Map<String, dynamic>) {
        throw const FormatException('Gemini response was not a JSON object.');
      }
      return Recipe.fromGemini(decoded, image: fallbackImage);
    } on FormatException catch (e) {
      throw FormatException('Invalid recipe format from AI: ${e.message}');
    } catch (error) {
      throw FormatException('Could not parse Gemini recipe: $error');
    }
  }
}
