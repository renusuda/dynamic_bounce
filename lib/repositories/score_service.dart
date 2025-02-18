import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_bounce/repositories/local_database.dart';
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

  /// The instance of the local database.
  static final instance = LocalDatabase();

  /// The table name.
  static const _tableName = LocalDatabase.tableName;

  /// The column name for the user id.
  static const _columnUserId = LocalDatabase.columnUserId;

  /// The column name for the best score.
  static const _columnBestScore = LocalDatabase.columnBestScore;

  /// The authentication instance.
  final FirebaseAuth auth;

  /// The Firestore instance.
  final FirebaseFirestore firestore;

  /// Get the best score.
  Future<int> getBestScore() async {
    final db = await instance.database;
    final userId = auth.currentUser!.uid;
    final result = await db.query(
      _tableName,
      columns: [
        _columnBestScore,
      ],
      where: '$_columnUserId = ?',
      whereArgs: [userId],
    );
    return result.first[_columnBestScore]! as int;
  }

  /// Update the best score.
  Future<void> updateBestScore(int score) async {
    final db = await instance.database;
    final userId = auth.currentUser!.uid;
    await db.update(
      _tableName,
      {
        _columnBestScore: score,
      },
      where: '$_columnUserId = ?',
      whereArgs: [userId],
    );
  }

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
