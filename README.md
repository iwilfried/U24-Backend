# Slide Management Application for U24-Backend

This Flutter application is designed to manage slides in a Firebase Firestore database. It includes features such as viewing, adding, editing, and deleting slides, using the `Bloc` pattern for state management.

## Table of Contents

- [Getting Started](#getting-started)
- [Project Structure](#project-structure)
- [Key Components](#key-components)
   - [Cubit](#1-cubit)
   - [Firestore Service](#2-firestore-service)
   - [Screens](#3-screens)
   - [Dialogs](#4-dialogs)
- [Firebase Configuration](#firebase-configuration)

## Getting Started

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-repo/slide-management-app.git



## Project structure
```
lib/
│
├── data/
│   ├── models/
│   │   └── slide.dart
│   └── services/
│       └── firestore_service.dart
│
├── presentation/
│   ├── cubits/
│   │   └── slide_management_cubit/
│   │       ├── slide_management_cubit.dart
│   │       └── slide_management_state.dart
│   ├── screens/
│   │   └── admin_slides_screen.dart
│   └── slides_show_dialogs.dart
│
└── main.dart
```

## Key Components

### 1. Cubit

- **Path**: `lib/presentation/cubits/slide_management_cubit/slide_management_cubit.dart`

- **Description**:
  The `SlideManagementCubit` is a state management class that handles the logic for loading, adding, updating, and deleting slides. It extends `Cubit` and uses the Bloc pattern to manage the state of the application.

- **Usage**:
  The Cubit is responsible for managing the state of the slide management feature. It listens for changes in the Firestore database and emits states like `SlidesLoadedSuccessfully`, `SlideManagementFailure`, etc., which are then used to update the UI.

### 2. Firestore Service

- **Path**: `lib/data/services/firestore_service.dart`

- **Description**:
  The `SlidesFirestoreService` is a service class that interacts with Firebase Firestore to perform CRUD (Create, Read, Update, Delete) operations on the slides.

- **Usage**:
  This service is used by the `SlideManagementCubit` to fetch, add, update, and delete slides in the Firestore database. It's provided at the top level of the app using `RepositoryProvider` to make it accessible throughout the app.

### 3. Screens

- **Path**: `lib/presentation/screens/admin_slides_screen.dart`

- **Description**:
  The `AdminSlideScreen` is the main screen of the application where the user can view all slides and perform actions like adding, editing, or deleting slides.

- **Usage**:
  This screen uses `BlocBuilder` to listen to the states emitted by the `SlideManagementCubit` and update the UI accordingly. It displays a `DataTable` with the slides' questions, answers, and action buttons for editing or deleting slides. A floating action button is also provided to add new slides.

### 4. Dialogs

- **Path**: `lib/presentation/slides_show_dialogs.dart`

- **Description**:
  The `SlidesShowDialogs` class provides utility functions to show dialogs for adding, editing, and deleting slides.

- **Usage**:
   - **Edit Slide Dialog**: Displays a dialog with input fields pre-filled with the selected slide's data, allowing the user to modify the slide.
   - **Add Slide Dialog**: Displays a dialog with empty input fields to add a new slide.
   - **Delete Slide Dialog**: Displays a confirmation dialog before deleting a slide.


## Firebase Configuration

The Firebase configuration is initialized in the `main.dart` file. The application connects to Firebase using the following options:

```dart
Firebase.initializeApp(
  options: const FirebaseOptions(
    apiKey: "your-api-key",
    appId: "your-app-id",
    messagingSenderId: "your-messaging-sender-id",
    projectId: "your-project-id",
  ),
);
