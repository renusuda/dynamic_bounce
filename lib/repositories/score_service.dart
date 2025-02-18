import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_bounce/repositories/local_database.dart';
import 'package:dynamic_bounce/repositories/user_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'score_service.g.dart';

/// The score service provider.
@riverpod
ScoreService scoreService(Ref ref) {
  final firestore = FirebaseFirestore.instance;
  return ScoreService(
    ref: ref,
    firestore: firestore,
  );
}

/// The score service.
class ScoreService {
  /// Creates a new score service.
  ScoreService({
    required this.ref,
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

  /// The reference.
  final Ref ref;

  /// The Firestore instance.
  final FirebaseFirestore firestore;

  /// Get the best score.
  Future<int> getBestScore() async {
    final db = await instance.database;
    final userId = await ref.watch(userServiceProvider).getUserId();
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
    final userId = await ref.watch(userServiceProvider).getUserId();
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
    final userId = await ref.watch(userServiceProvider).getUserId();
    await FirebaseFirestore.instance
        .collection('scores')
        .doc(userId)
        .set(<String, dynamic>{
      'score': score,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
