import 'package:dynamic_bounce/firebase_options_dev.dart' as dev;
import 'package:dynamic_bounce/firebase_options_prod.dart' as prod;
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
