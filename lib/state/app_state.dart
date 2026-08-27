import 'package:flutter/foundation.dart';
import '../models/ingredient.dart';
import '../models/recipe.dart';
import '../services/gemini_service.dart';

class AppState extends ChangeNotifier {
  final GeminiService gemini = GeminiService();
  // Active Ingredients List
  final List<Ingredient> _ingredients = [
    const Ingredient(id: '1', name: '4 Large Eggs', emoji: '🥚'),
    const Ingredient(id: '2', name: 'Cherry Tomatoes', emoji: '🍅'),
    const Ingredient(id: '3', name: '3 Garlic Cloves', emoji: '🧄'),
    const Ingredient(id: '4', name: 'Parmesan Cheese', emoji: '🧀'),
    const Ingredient(id: '5', name: 'Fresh Basil', emoji: '🌿'),
  ];

  // Saved Recipe IDs
  final Set<String> _savedRecipeIds = {
    'garlic-chicken',
    'tuscan-salmon',
    'chipotle-chicken-bowl',
  };

  // Recipe Database
  final List<Recipe> _allRecipes = const [
    Recipe(
      id: 'garlic-chicken',
      title: 'Rustic Garlic Herb Chicken',
      subtitle:
          'Tender chicken breasts in a rich garlic tomato herb butter sauce',
      image:
          'https://images.unsplash.com/photo-1604908176997-125f25cc6f3d?auto=format&fit=crop&w=800&q=80',
      time: '25 min',
      prepTime: '10 min',
      cookTime: '15 min',
      difficulty: 'Easy',
      rating: '4.9',
      reviews: 142,
      match: 95,
      calories: '480 kcal',
      protein: '44g',
      carbs: '6g',
      fat: '28g',
      category: 'High Protein',
      tags: ['High Protein', 'Under 30m', 'Keto', 'Favorites'],
      ingredients: [
        '2 Boneless, skinless Chicken Breasts (sliced into cutlets)',
        '3 cloves fresh Garlic (finely minced)',
        '1 cup sweet Cherry Tomatoes (halved)',
        '1 tbsp Extra Virgin Olive Oil',
        '2 tbsp unsalted Butter',
        '1/2 cup Heavy Cream (or full-fat coconut cream)',
        '1/4 cup freshly grated Parmesan Cheese',
        'Fresh Basil leaves & cracked black pepper',
      ],
      steps: [
        RecipeStep(
          num: 1,
          title: 'Sear Chicken Cutlets',
          text:
              'Heat 1 tbsp olive oil and 1 tbsp butter in a heavy cast-iron skillet over medium-high heat. Season chicken generously with salt and pepper. Sear for 6-8 minutes, turning once until golden brown and cooked through.',
          timerSec: 480,
        ),
        RecipeStep(
          num: 2,
          title: 'Sauté Aromatics & Tomatoes',
          text:
              'Lower the heat to medium. Add minced garlic and halved cherry tomatoes to the pan drippings. Sauté for 2-3 minutes until fragrant and tomatoes begin to blister slightly.',
          timerSec: 180,
        ),
        RecipeStep(
          num: 3,
          title: 'Simmer Creamy Sauce',
          text:
              'Pour in heavy cream and scrape up any golden browned bits from the bottom of the pan. Simmer for 3 minutes until slightly thickened. Stir in grated parmesan cheese until silky.',
          timerSec: 180,
        ),
        RecipeStep(
          num: 4,
          title: 'Combine & Garnish',
          text:
              'Return seared chicken cutlets back into the bubbling sauce. Spoon sauce over the top, remove from heat, and fold in torn fresh basil leaves. Serve immediately while warm.',
          timerSec: 0,
        ),
      ],
      proTip:
          'Deglaze the skillet with a splash of dry white wine or chicken bone broth before pouring cream for maximum depth of flavor.',
    ),
    Recipe(
      id: 'tuscan-salmon',
      title: 'Tuscan Garlic Butter Salmon',
      subtitle:
          'Crispy pan-seared salmon fillet in creamy spinach & sun-dried tomato sauce',
      image:
          'https://images.unsplash.com/photo-1467003909585-2f8a72700288?auto=format&fit=crop&w=800&q=80',
      time: '20 min',
      prepTime: '5 min',
      cookTime: '15 min',
      difficulty: 'Easy',
      rating: '4.9',
      reviews: 98,
      match: 92,
      calories: '520 kcal',
      protein: '38g',
      carbs: '8g',
      fat: '36g',
      category: 'Quick & Easy',
      tags: ['Quick & Easy', 'Under 20m', 'High Protein'],
      ingredients: [
        '2 Fresh Salmon Fillets (skin-on or skinless)',
        '4 cloves Garlic (minced)',
        '1/2 cup Sun-Dried Tomatoes (drained)',
        '2 cups Baby Spinach',
        '1/2 cup Heavy Cream',
        '1 tbsp Olive Oil & 1 tbsp Butter',
      ],
      steps: [
        RecipeStep(
          num: 1,
          title: 'Crisp the Salmon',
          text:
              'Season salmon fillets with sea salt and black pepper. Sear skin-side down in hot olive oil for 5 minutes until crispy, flip and cook 3 minutes more. Transfer to a plate.',
          timerSec: 300,
        ),
        RecipeStep(
          num: 2,
          title: 'Make Tuscan Sauce',
          text:
              'Melt butter in skillet, add garlic and sun-dried tomatoes for 1 minute. Add spinach and let wilt. Stir in cream and bring to a gentle bubble.',
          timerSec: 120,
        ),
        RecipeStep(
          num: 3,
          title: 'Rest & Serve',
          text:
              'Nestle salmon fillets back into the cream sauce. Spoon warm sauce over fish and finish with a squeeze of fresh lemon juice.',
          timerSec: 60,
        ),
      ],
      proTip:
          'Pat salmon fillets bone-dry with paper towels before seasoning to guarantee an ultra-crispy crust.',
    ),
    Recipe(
      id: 'chipotle-chicken-bowl',
      title: 'Smoky Chipotle Chicken Bowl',
      subtitle:
          'Fire-grilled chipotle chicken with charred corn, avocado, and lime crema',
      image:
          'https://images.unsplash.com/photo-1543339308-43e59d6b73a6?auto=format&fit=crop&w=800&q=80',
      time: '20 min',
      prepTime: '10 min',
      cookTime: '10 min',
      difficulty: 'Medium',
      rating: '4.8',
      reviews: 86,
      match: 90,
      calories: '450 kcal',
      protein: '42g',
      carbs: '34g',
      fat: '16g',
      category: 'High Protein',
      tags: ['High Protein', 'Under 20m', 'Favorites'],
      ingredients: [
        '300g Chicken Breast (cubed)',
        '1 tbsp Chipotle in Adobo sauce',
        '1 cup Charred Sweet Corn',
        '1 ripe Avocado (diced)',
        '1/2 cup Greek Yogurt or Lime Crema',
        'Fresh Cilantro and Lime wedges',
      ],
      steps: [
        RecipeStep(
          num: 1,
          title: 'Marinate & Grill Chicken',
          text:
              'Toss diced chicken with chipotle sauce, cumin, and garlic powder. Sear on high heat for 7-8 minutes until slightly charred on the edges.',
          timerSec: 480,
        ),
        RecipeStep(
          num: 2,
          title: 'Assemble Protein Bowl',
          text:
              'Layer your base of quinoa or greens, top with chipotle chicken, charred corn, diced avocado, cilantro, and generous lime crema.',
          timerSec: 0,
        ),
      ],
      proTip:
          'Grill sweet corn in a dry pan until blistered to add an authentic woodfire barbecue note.',
    ),
    Recipe(
      id: 'sun-dried-pasta',
      title: 'Creamy Sun-Dried Tomato Pasta',
      subtitle:
          'Silky garlic cream penne pasta with blistered tomatoes, spinach, and parmesan',
      image:
          'https://images.unsplash.com/photo-1621996346565-e3d5d628169e?auto=format&fit=crop&w=800&q=80',
      time: '15 min',
      prepTime: '5 min',
      cookTime: '10 min',
      difficulty: 'Easy',
      rating: '4.9',
      reviews: 110,
      match: 88,
      calories: '380 kcal',
      protein: '14g',
      carbs: '52g',
      fat: '14g',
      category: 'Italian',
      tags: ['Italian', 'Under 20m', 'Vegetarian'],
      ingredients: [
        '200g Penne or Fettuccine Pasta',
        '1/3 cup Sun-Dried Tomatoes (chopped)',
        '3 cloves Garlic (crushed)',
        '3/4 cup Heavy Cream or Oat Cream',
        '1/2 cup Fresh Parmesan Cheese',
        'Fresh Basil and Red Pepper Flakes',
      ],
      steps: [
        RecipeStep(
          num: 1,
          title: 'Boil Pasta Al Dente',
          text:
              'Cook pasta in heavily salted boiling water for 8 minutes. Reserve 1/2 cup starchy pasta water before draining.',
          timerSec: 480,
        ),
        RecipeStep(
          num: 2,
          title: 'Make Cream Sauce',
          text:
              'Sauté garlic and sun-dried tomatoes in olive oil for 2 minutes. Stir in cream and simmer 2 minutes. Toss pasta and parmesan until emulsified.',
          timerSec: 240,
        ),
      ],
      proTip:
          'Adding a few tablespoons of reserved starchy pasta water gives the sauce that glossy restaurant sheen.',
    ),
    Recipe(
      id: 'avocado-egg-skillet',
      title: 'Avocado & Egg Breakfast Skillet',
      subtitle:
          'Golden baked eggs in crushed tomatoes, feta, and fresh avocado slices',
      image:
          'https://images.unsplash.com/photo-1525351484163-7529414344d8?auto=format&fit=crop&w=800&q=80',
      time: '12 min',
      prepTime: '4 min',
      cookTime: '8 min',
      difficulty: 'Easy',
      rating: '4.7',
      reviews: 64,
      match: 94,
      calories: '310 kcal',
      protein: '18g',
      carbs: '9g',
      fat: '22g',
      category: 'Quick & Easy',
      tags: ['Quick & Easy', 'Under 20m', 'Vegetarian', 'Keto'],
      ingredients: [
        '3 Farm Fresh Eggs',
        '1/2 ripe Avocado (sliced)',
        '1 cup Crushed San Marzano Tomatoes',
        '2 tbsp Crumbled Feta Cheese',
        '1 tbsp Olive Oil',
        'Smoked Paprika & Fresh Herbs',
      ],
      steps: [
        RecipeStep(
          num: 1,
          title: 'Simmer Tomato Base',
          text:
              'Heat olive oil in a small skillet. Add crushed tomatoes, pinch of paprika, and simmer for 3 minutes until bubbling.',
          timerSec: 180,
        ),
        RecipeStep(
          num: 2,
          title: 'Poach Eggs in Sauce',
          text:
              'Make 3 small wells in the tomato sauce and crack eggs directly in. Cover and cook on low heat for 4-5 minutes until whites are set.',
          timerSec: 270,
        ),
        RecipeStep(
          num: 3,
          title: 'Garnish & Serve',
          text:
              'Top with sliced avocado, crumbled feta, and fresh cilantro. Serve straight from the warm skillet.',
          timerSec: 0,
        ),
      ],
      proTip:
          'Keep skillet covered on gentle low heat to cook the egg whites thoroughly while keeping the yolks velvety and runny.',
    ),
    Recipe(
      id: 'teriyaki-beef',
      title: 'Teriyaki Sesame Glazed Beef',
      subtitle:
          'Thinly sliced flank steak caramelized in honey ginger soy glaze with sesame',
      image:
          'https://images.unsplash.com/photo-1534422298391-e4f8c172dddb?auto=format&fit=crop&w=800&q=80',
      time: '30 min',
      prepTime: '15 min',
      cookTime: '15 min',
      difficulty: 'Medium',
      rating: '4.8',
      reviews: 79,
      match: 85,
      calories: '580 kcal',
      protein: '46g',
      carbs: '22g',
      fat: '28g',
      category: 'Asian',
      tags: ['Asian', 'High Protein', 'Favorites'],
      ingredients: [
        '350g Flank Steak (sliced thin against grain)',
        '3 tbsp Low Sodium Soy Sauce',
        '2 tbsp Honey or Brown Sugar',
        '1 tbsp Grated Fresh Ginger',
        '2 cloves Garlic (minced)',
        'Toasted Sesame Seeds & Green Onions',
      ],
      steps: [
        RecipeStep(
          num: 1,
          title: 'High Heat Beef Flash Sear',
          text:
              'Sear sliced beef in a screaming hot wok or cast iron pan for 3-4 minutes until nicely browned. Set aside.',
          timerSec: 240,
        ),
        RecipeStep(
          num: 2,
          title: 'Caramelize Teriyaki Glaze',
          text:
              'In the same pan, simmer soy sauce, honey, garlic, and ginger until thick and glossy (about 2 minutes). Return beef, coat well, and top with sesame seeds.',
          timerSec: 120,
        ),
      ],
      proTip:
          'Slice flank steak across the grain at a 45-degree angle for maximum melt-in-your-mouth tenderness.',
    ),
  ];

  late Recipe _selectedRecipe;

  AppState() {
    _selectedRecipe = _allRecipes.first;
  }

  // Getters
  List<Ingredient> get ingredients => List.unmodifiable(_ingredients);
  List<Recipe> get allRecipes => List.unmodifiable(_allRecipes);
  List<Recipe> get savedRecipes =>
      _allRecipes.where((r) => _savedRecipeIds.contains(r.id)).toList();
  Recipe get selectedRecipe => _selectedRecipe;
  Set<String> get savedRecipeIds => Set.unmodifiable(_savedRecipeIds);

  bool isSaved(String recipeId) => _savedRecipeIds.contains(recipeId);

  // Actions
  void addIngredient(String name, [String? emoji]) {
    final cleanName = name.trim();
    if (cleanName.isEmpty) return;

    final assignedEmoji = emoji ?? Ingredient.guessEmoji(cleanName);
    _ingredients.add(
      Ingredient(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: cleanName,
        emoji: assignedEmoji,
      ),
    );
    notifyListeners();
  }

  void removeIngredient(String id) {
    _ingredients.removeWhere((i) => i.id == id);
    notifyListeners();
  }

  void clearIngredients() {
    _ingredients.clear();
    notifyListeners();
  }

  bool toggleSaveRecipe(String recipeId) {
    final isSaved = _savedRecipeIds.contains(recipeId);
    if (isSaved) {
      _savedRecipeIds.remove(recipeId);
    } else {
      _savedRecipeIds.add(recipeId);
    }
    notifyListeners();
    return !isSaved;
  }

  void selectRecipe(Recipe recipe) {
    _selectedRecipe = recipe;
    notifyListeners();
  }

  void selectRecipeById(String recipeId) {
    final recipe = _allRecipes.firstWhere(
      (r) => r.id == recipeId,
      orElse: () => _allRecipes.first,
    );
    _selectedRecipe = recipe;
    notifyListeners();
  }

  Future<void> generateRecipeWithGemini({
    String dietaryGoal = 'balanced',
    String maxCookingTime = 'any time',
  }) async {
    final generated = await gemini.generateRecipeFromIngredients(
      _ingredients.map((ingredient) => ingredient.name),
      dietaryGoal: dietaryGoal,
      maxCookingTime: maxCookingTime,
      fallbackImage: _allRecipes.first.image,
    );
    _selectedRecipe = generated;
    notifyListeners();
  }
}
