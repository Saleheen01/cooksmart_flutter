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

For local development, provide a Gemini API key at run time:

```powershell
flutter pub get
flutter run --dart-define=GEMINI_API_KEY=your_key_here
```

The app can build without the define, but AI recipe generation requires a
working Gemini configuration.

## Gemini configuration and security

Gemini is accessed through `google_generative_ai` in
`lib/services/gemini_service.dart`. The current source reads the key from the
`GEMINI_API_KEY` compile-time define (or an explicitly supplied constructor
argument); it does not contain a hard-coded fallback key.

Use the define only for local development and testing:

```powershell
flutter run --dart-define=GEMINI_API_KEY=your_key_here
```

**Important:** A key passed through `--dart-define` is compiled into the
Flutter application and can be extracted from a distributed APK. It is not a
secure way to store a production secret. For production, send Gemini requests
through a trusted backend that keeps the key server-side and applies
authentication, quotas, and abuse protection.

If a Gemini key was ever committed to this repository or included in a
distributed build, revoke/rotate it in Google AI Studio. Removing a key from
the latest source does not remove it from Git history or previously distributed
builds.

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

Only use a restricted development/test key for this client-side build. Do not
ship a production Gemini credential inside the APK.

The resulting APK is written to
`build/app/outputs/flutter-apk/app-release.apk`.

## A note from the kitchen

CookSmart is a focused project: fewer decisions, better use of what is already
in the pantry, and a recipe you can start cooking before takeout becomes the
default plan.
