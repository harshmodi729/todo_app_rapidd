# todo_app

A Todo app where tasks can be shared with other users and can be updated real time using MVVM + Riverpod.

## Features

*   Create, read, update, and delete tasks. Tasks has titles, detailed descriptions, and done/undone state.
*   Tasks can be update instantly.
*   Owners can share tasks with other users via email. Other users can view and edit shared tasks.
*   Simple email-based setup to track ownership.
*   The UI automatically adapts to different screen sizes using the `responsive_framework` lib.
*   Add support for localization (l10n).

## Tech Stack & Architecture

*   Clean Architecture (Data, Domain, Presentation layers) with MVVM.
*   Flutter Riverpod(using `AsyncNotifier` for reactive data loading).
*   Firebase Firestore.
*   GoRouter for navigation.
*   Freezed for immutable data models.

## Screenshots
*   https://github.com/harshmodi729/todo_app_rapidd/blob/main/screenshots/Screenshot_1763986907.png
*   https://github.com/harshmodi729/todo_app_rapidd/blob/main/screenshots/Screenshot_1763986914.png
*   https://github.com/harshmodi729/todo_app_rapidd/blob/main/screenshots/Screenshot_1763986920.png
*   https://github.com/harshmodi729/todo_app_rapidd/blob/main/screenshots/Screenshot_1763986924.png
*   https://github.com/harshmodi729/todo_app_rapidd/blob/main/screenshots/Screenshot_1763986929.png
*   https://github.com/harshmodi729/todo_app_rapidd/blob/main/screenshots/Screenshot_1763986933.png
*   https://github.com/harshmodi729/todo_app_rapidd/blob/main/screenshots/Screenshot_1763986937.png
*   https://github.com/harshmodi729/todo_app_rapidd/blob/main/screenshots/Screenshot_1763986941.png

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
