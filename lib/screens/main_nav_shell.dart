import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/bottom_nav_bar.dart';
import 'home_screen.dart';
import 'ingredients_screen.dart';
import 'recipe_result_screen.dart';
import 'saved_recipes_screen.dart';

class MainNavShell extends StatefulWidget {
  const MainNavShell({super.key});

  @override
  State<MainNavShell> createState() => _MainNavShellState();
}

class _MainNavShellState extends State<MainNavShell> {
  int _currentIndex = 0;

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // For Desktop / Web viewports, center with maximum mobile width
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 440),
          decoration: BoxDecoration(
            color: AppColors.background,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.8),
                blurRadius: 40,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Scaffold(
            backgroundColor: AppColors.background,
            body: IndexedStack(
              index: _currentIndex,
              children: [
                HomeScreen(
                  onNavigateToIngredients: () => _onTabTapped(1),
                  onNavigateToRecipe: () => _onTabTapped(2),
                ),
                IngredientsScreen(
                  onNavigateBack: () => _onTabTapped(0),
                  onGenerateRecipe: () => _onTabTapped(2),
                ),
                RecipeResultScreen(onNavigateBack: () => _onTabTapped(1)),
                SavedRecipesScreen(
                  onNavigateToIngredients: () => _onTabTapped(1),
                  onNavigateToRecipe: () => _onTabTapped(2),
                ),
              ],
            ),
            bottomNavigationBar: CookSmartBottomNavBar(
              currentIndex: _currentIndex,
              onTap: _onTabTapped,
            ),
          ),
        ),
      ),
    );
  }
}
