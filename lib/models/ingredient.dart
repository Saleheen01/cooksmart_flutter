class Ingredient {
  final String id;
  final String name;
  final String emoji;

  const Ingredient({required this.id, required this.name, required this.emoji});

  Ingredient copyWith({String? id, String? name, String? emoji}) {
    return Ingredient(
      id: id ?? this.id,
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
    );
  }

  static String guessEmoji(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('egg')) return '🥚';
    if (lower.contains('tomato')) return '🍅';
    if (lower.contains('garlic')) return '🧄';
    if (lower.contains('cheese') || lower.contains('parmesan')) return '🧀';
    if (lower.contains('basil') || lower.contains('herb')) return '🌿';
    if (lower.contains('chicken') || lower.contains('poultry')) return '🍗';
    if (lower.contains('beef') || lower.contains('steak')) return '🥩';
    if (lower.contains('fish') || lower.contains('salmon')) return '🐟';
    if (lower.contains('pasta') || lower.contains('noodle')) return '🍝';
    if (lower.contains('rice')) return '🍚';
    if (lower.contains('onion')) return '🧅';
    if (lower.contains('lemon')) return '🍋';
    if (lower.contains('oil') || lower.contains('olive')) return '🫒';
    if (lower.contains('butter')) return '🧈';
    if (lower.contains('pepper') || lower.contains('salt')) return '🧂';
    if (lower.contains('cream') || lower.contains('milk')) return '🥛';
    if (lower.contains('avocado')) return '🥑';
    if (lower.contains('spinach')) return '🥬';
    if (lower.contains('mushroom')) return '🍄';
    if (lower.contains('potato')) return '🥔';
    return '🥘';
  }
}
