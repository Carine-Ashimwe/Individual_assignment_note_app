# Notes App

A Flutter mobile application with Firebase authentication and Firestore database for note management.

## Features

- Email/password authentication using Firebase Auth
- Create, read, update, and delete notes
- Real-time synchronization with Firestore
- Clean architecture with Provider state management
- Input validation and error handling

## Technologies Used

- Flutter 3.7.2+
- Firebase Authentication
- Cloud Firestore
- Provider (State Management)

## Project Structure

```
lib/
├── main.dart
├── models/
│   └── note.dart
├── providers/
│   ├── auth_provider.dart
│   └── notes_provider.dart
├── repositories/
│   ├── auth_repository.dart
│   └── notes_repository.dart
├── screens/
│   ├── auth/
│   │   └── login_screen.dart
│   └── notes/
│       └── notes_screen.dart
└── widgets/
    ├── note_card.dart
    └── note_dialog.dart
```

## Setup Instructions

1. Clone the repository
2. Run `flutter pub get` to install dependencies
3. Set up Firebase project:
   - Create project at Firebase Console
   - Enable Email/Password authentication
   - Create Firestore database in test mode
   - Run `flutterfire configure` to add configuration files
4. Run `flutter run` to start the application

## Requirements Met

- Firebase authentication with email/password
- Complete CRUD operations for notes
- Provider state management (no setState used)
- Clean architecture with separated concerns
- User input validation and error handling
- Confirmation dialogs for destructive actions
- Loading states and user feedback

## Platform Support

- Android (API 23+)
- iOS (13.0+)
