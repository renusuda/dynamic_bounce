import 'package:dynamic_bounce/firebase_options_dev.dart' as dev;
import 'package:dynamic_bounce/firebase_options_prod.dart' as prod;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

/// Initialize Firebase app based on the current flavor.
Future<void> initializeFirebaseApp() async {
  // Determine which Firebase options to use based on the flavor
  final firebaseOptions = switch (appFlavor) {
    'dev' => dev.DefaultFirebaseOptions.currentPlatform,
    'prod' => prod.DefaultFirebaseOptions.currentPlatform,
    _ => throw UnsupportedError('Invalid flavor: $appFlavor'),
  };
  await Firebase.initializeApp(options: firebaseOptions);
}

/// Sign in anonymously if not already signed in.
Future<void> signInAnonymously() async {
  try {
    await FirebaseAuth.instance.signInAnonymously();
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case 'operation-not-allowed':
        throw Exception("Anonymous auth hasn't been enabled for this project.");
      default:
        throw Exception('Unknown error.');
    }
  }
}
