# Superstars Network — Flutter App

> A professional **video networking** app built in Flutter/Dart — connect with professionals, record a 60-second pitch, and grow your network.

This project was built to demonstrate production-ready Flutter/Dart architecture, clean code organization, and familiarity with the professional networking domain — directly relevant to [Superstars](https://superstars.co).

---

## Features

- **Home Feed** — Video pitch feed with real-time stats (views, likes, connections)
- **Discover** — Search professionals by name, role, skill, or company
- **Video Pitch** — Record and publish a 60-second intro video
- **My Network** — Manage and message your connections
- **Profile** — Skills, industries, bio, pitch history

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter 3.x / Dart 3.x |
| State Management | Provider + ChangeNotifier |
| Navigation | GoRouter (deep linking ready) |
| Local Storage | SharedPreferences |
| Architecture | Feature-first, service layer pattern |
| Testing | flutter_test + mockito |
| Linting | flutter_lints (strict ruleset) |

---

## Project Structure

```
lib/
├── main.dart               # App entry, routing, theme
├── models/
│   ├── user_profile.dart   # User model with fromJson/toJson/copyWith
│   └── video_pitch.dart    # Video pitch model
├── services/
│   ├── auth_service.dart   # Auth state (ChangeNotifier)
│   └── user_service.dart   # User data, search, connections
├── screens/
│   ├── home_screen.dart    # Feed + stats dashboard
│   ├── discover_screen.dart# Search + connect
│   ├── video_pitch_screen.dart
│   ├── connection_screen.dart
│   └── profile_screen.dart
└── widgets/
    ├── user_avatar.dart
    └── video_pitch_card.dart

test/
└── user_service_test.dart  # Unit tests for service + model layer
```

---

## Architecture Decisions

- **Provider over Riverpod/Bloc** — Chosen for simplicity and zero boilerplate; easy to migrate to Riverpod as the app scales
- **GoRouter** — Supports deep linking and shell routing for bottom nav; production-standard for Flutter apps
- **Service layer** — `UserService` and `AuthService` are decoupled from UI. Swapping the mock data for real API calls requires zero widget changes
- **copyWith pattern** — All models are immutable with `copyWith` for clean state updates
- **Strict linting** — `analysis_options.yaml` enforces return types, const constructors, and key usage

---

## Getting Started

```bash
# Clone
git clone https://github.com/kartikkumarpandya/superstars-network-flutter.git
cd superstars-network-flutter

# Install deps
flutter pub get

# Run
flutter run

# Tests
flutter test
```

**Requires:** Flutter 3.10+ / Dart 3.0+

---

## What's Next (Roadmap)

- [ ] Firebase Auth + Firestore integration
- [ ] Real camera recording with `camera` package
- [ ] Push notifications via FCM
- [ ] Video playback with `video_player`
- [ ] CI/CD pipeline (GitHub Actions)

---

## About

Built by **Kartikkumar Pandya** — Software Engineering student returning to university August 2026.  
Interested in fast-moving Flutter projects with real-world impact.

[![GitHub](https://img.shields.io/badge/GitHub-kartikkumarpandya-181717?style=flat&logo=github)](https://github.com/kartikkumarpandya)
