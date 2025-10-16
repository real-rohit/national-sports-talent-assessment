# Copilot Instructions for nsta_app

## Project Overview
- **Type:** Flutter mobile app (Dart)
- **Purpose:** National Sports Talent Assessment (NSTA) application for conducting and recording sports tests (e.g., vertical jump)
- **Key Features:** Camera-based tests, demo/test flows, Firebase integration

## Architecture & Structure
- **Main entry:** `lib/main.dart`
- **Feature modules:** Located in `lib/src/features/` (e.g., `tests/` for test-related screens)
- **Widgets:** Shared UI components in `lib/src/shared/widgets/`
- **Platform code:** Android/iOS-specific code in `android/` and `ios/`
- **Assets:** Images in `assets/images/`

## Patterns & Conventions
- **Navigation:** Uses `get` package (`Get.to(...)`, `Get.back()`) for routing/navigation
- **Buttons:** Use `PrimaryButton` and `SecondaryButton` from shared widgets
- **Screen structure:** Each test/feature has an intro screen and a test/demo screen (see `vertical_jump_intro_screen.dart`)
- **State management:** Minimal, mostly via StatefulWidget; no global state management detected
- **Naming:** Feature folders and files are lower_snake_case; widgets/classes are UpperCamelCase

## Developer Workflows
- **Build:**
  - `flutter pub get` (fetch dependencies)
  - `flutter run` (run app on device/emulator)
- **Test:**
  - Widget tests in `test/` (e.g., `widget_test.dart`)
  - Run: `flutter test`
- **Firebase:**
  - Configured via `google-services.json` (Android) and `firebase.json`
  - Rules in `firestore.rules`, indexes in `firestore.indexes.json`
- **Assets:**
  - Add new images to `assets/images/` and update `pubspec.yaml` under `assets:`

## Integration Points
- **Firebase:** Auth, Firestore (see config files in root and `android/app/`)
- **Camera/ML:** Likely uses camera and pose detection plugins (see dependencies in `pubspec.yaml`)

## Examples
- To add a new test:
  1. Create a new folder in `lib/src/features/tests/`
  2. Add intro and test/demo screens
  3. Register navigation using `Get.to()`

- To add a button:
  ```dart
  PrimaryButton(label: 'Start', onPressed: () { /* ... */ })
  ```

## References
- See `lib/src/features/tests/veritcal_jump.dart/vertical_jump_intro_screen.dart` for a typical feature intro screen
- See `pubspec.yaml` for dependencies and asset registration

---
If any conventions or workflows are unclear, please ask for clarification or examples from the codebase.
