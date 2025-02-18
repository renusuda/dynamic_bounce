import 'package:dynamic_bounce/firebase.dart';
import 'package:dynamic_bounce/repositories/local_database.dart';
import 'package:dynamic_bounce/widgets/game_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Lock the orientation to portrait up and down.
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await initializeFirebaseApp();
  await signInAnonymously();
  await LocalDatabase().database;
  runApp(
    const ProviderScope(
      child: GameApp(),
    ),
  );
}
