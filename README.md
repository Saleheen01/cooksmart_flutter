# CookSmart

CookSmart is a small AI-assisted kitchen companion for the moment when you are
standing in front of the fridge thinking, "What can I actually make with this?"

Add what you have, choose a time limit and dietary goal, and CookSmart turns the
ingredients into a practical recipe with measured ingredients, numbered steps,
and useful cooking timers. When you are browsing instead, the app also includes
a curated recipe collection and a personal cookbook for recipes worth making
again.

## What is inside

- **Discover** - Search and filter recipes by categories such as Quick & Easy,
	High Protein, Italian, Asian, and Keto.
- **Pantry & Ingredients** - Add ingredients one at a time, use common pantry
	staples, and remove everything with a single action.
- **AI Recipe Builder** - Send your ingredients, dietary goal, and cooking-time
	preference to Gemini for a new recipe.
- **Recipe details** - Follow measured ingredients and numbered instructions,
	check ingredients off as you go, and start a timer for timed steps.
- **Personal Cookbook** - Save recipes and find them later with search and
	filters for favorites, short recipes, protein-focused meals, and vegetarian
	options.

The app is intentionally mobile-first. On wider screens, the experience stays
in a centered phone-sized frame so the cooking flow remains easy to scan.

## Getting started

### Prerequisites

- Flutter SDK with Dart 3.12.2 or newer
- Android Studio and an Android SDK (API 35 or newer)
- An Android emulator or a USB-connected Android device

Open the project root, `cooksmart_flutter`, in Android Studio or VS Code. Do
not open only the `android/` directory.

```powershell
flutter pub get
flutter run --dart-define=GEMINI_API_KEY=your_key_here
```

The app can still build without the define, but generating a recipe requires a
working Gemini configuration. Before sharing a build publicly, remove any
fallback credential from `GeminiService` and use a backend-held secret instead.

## Gemini configuration

Gemini is accessed through `google_generative_ai` in
`lib/services/gemini_service.dart`. Pass the key at run or build time rather
than adding it to source control:

```powershell
# Development
flutter run --dart-define=GEMINI_API_KEY=your_key_here

# Android release build
flutter build apk --release --dart-define=GEMINI_API_KEY=your_key_here
```

Treat an API key embedded in a mobile build as exposed: APK contents can be
inspected. For a production release, put Gemini behind a trusted backend with
server-side secrets, quotas, and abuse protection. If a key has ever been
committed or shared accidentally, rotate it before distributing the app.

## Project shape

```text
lib/
	main.dart                    App entry point and provider setup
	models/                      Ingredient and recipe data models
	screens/                     Home, pantry, recipe, and cookbook views
	services/gemini_service.dart Gemini client and response parsing
	state/app_state.dart         Shared ingredients, recipes, and saved state
	theme/                       Colors and the app theme
	widgets/                     Reusable cards, navigation, and cooking UI
```

The app currently keeps its sample recipes and session state in memory. A
future persistence layer could make saved recipes and pantry contents survive
restarts.

## Verify a change

```powershell
flutter analyze
flutter test
```

Build an installable Android package with:

```powershell
flutter build apk --release --dart-define=GEMINI_API_KEY=your_key_here
```

The resulting APK is written to
`build/app/outputs/flutter-apk/app-release.apk`.

## A note from the kitchen

CookSmart is a focused project: fewer decisions, better use of what is already
in the pantry, and a recipe you can start cooking before takeout becomes the
default plan.
