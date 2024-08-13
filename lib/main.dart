import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'presentation/screens/admin_slides_screen.dart';
import 'data/services/firestore_service.dart';

/// The entry point of the application. This is where the app starts.
Future<void> main() async {
  // Ensure that Flutter's binding is initialized before making any other async calls.
  WidgetsFlutterBinding.ensureInitialized();

  /// Initialize Firebase with specific options.
  /// This setup connects your app to Firebase services, allowing you to use Firestore, Authentication, etc.
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      /// Testing project creds, to be revoked
      apiKey: "API_KEY",
      appId: "APP_ID",
      messagingSenderId: "MSG_SENDING_ID",
      projectId: "PROJECT_ID",
    ),
  );

  // Run the Flutter application.
  runApp(const AdminApp());
}

/// The root widget of the application.
class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      /// Provide a single instance of `SlidesFirestoreService` to the entire app.
      /// This service is responsible for interacting with Firestore to manage slides.
      create: (context) => SlidesFirestoreService(),
      child: MaterialApp(
        /// The theme of the application is set to light mode.
        /// `useMaterial3: false` ensures that the app uses Material Design 2, the previous version of Material Design.
        theme: ThemeData.light(useMaterial3: false),

        /// The `home` property defines the default screen of the app, which is the `AdminSlideScreen`.
        home: const AdminSlideScreen(),
      ),
    );
  }
}
