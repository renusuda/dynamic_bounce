import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'score_service.g.dart';

/// The score service provider.
@riverpod
ScoreService scoreService(Ref ref) {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  return ScoreService(auth: auth, firestore: firestore);
}

/// The score service.
class ScoreService {
  /// Creates a new score service.
  ScoreService({
    required this.auth,
    required this.firestore,
  });

  /// The authentication instance.
  final FirebaseAuth auth;

  /// The Firestore instance.
  final FirebaseFirestore firestore;

  /// Upsert the score.
  Future<void> upsertScore(int score) async {
    await FirebaseFirestore.instance
        .collection('scores')
        .doc(auth.currentUser!.uid)
        .set(<String, dynamic>{
      'score': score,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
