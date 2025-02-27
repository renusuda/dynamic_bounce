import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dynamic_bounce/models/player_score.dart';
import 'package:dynamic_bounce/repositories/local_database.dart';
import 'package:dynamic_bounce/repositories/player_service.dart';
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

  /// Local database instance.
  static final instance = LocalDatabase();

  /// Table name.
  static const _tableName = LocalDatabase.tableName;

  /// Player ID column.
  static const _columnPlayerId = LocalDatabase.columnPlayerId;

  /// Best score column.
  static const _columnBestScore = LocalDatabase.columnBestScore;

  /// The reference.
  final Ref ref;

  /// The Firestore instance.
  final FirebaseFirestore firestore;

  /// Get the best score.
  Future<int> getBestScore() async {
    final db = await instance.database;
    final playerId = await ref.read(playerServiceProvider).getPlayerId();
    final result = await db.query(
      _tableName,
      columns: [
        _columnBestScore,
      ],
      where: '$_columnPlayerId = ?',
      whereArgs: [playerId],
    );
    return result.first[_columnBestScore]! as int;
  }

  /// Update the best score.
  Future<void> updateBestScore(int score) async {
    final db = await instance.database;
    final playerId = await ref.read(playerServiceProvider).getPlayerId();
    await db.update(
      _tableName,
      {
        _columnBestScore: score,
      },
      where: '$_columnPlayerId = ?',
      whereArgs: [playerId],
    );
  }

  /// Get the score in the top 100.
  Future<List<PlayerScore>> getTopPlayerScores() async {
    final playerScoresRef = FirebaseFirestore.instance
        .collection('scores')
        .withConverter<PlayerScore>(
          fromFirestore: (snapshot, _) => PlayerScore.fromJson(
            json: snapshot.data()!,
            id: snapshot.id,
          ),
          toFirestore: (playerScore, _) => playerScore.toJson(),
        );

    final response = await playerScoresRef
        .orderBy('score', descending: true)
        .orderBy('updatedAt', descending: true)
        .limit(100)
        .get();

    final topPlayerScores = response.docs.map((doc) => doc.data()).toList();

    return topPlayerScores;
  }

  /// Upsert the score.
  Future<void> upsertScore(int score) async {
    final player = await ref.read(playerServiceProvider).getPlayer();
    await FirebaseFirestore.instance
        .collection('scores')
        .doc(player.id)
        .set(<String, dynamic>{
      'name': player.name,
      'score': score,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Delete the score.
  Future<void> deleteScore() async {
    final player = await ref.read(playerServiceProvider).getPlayer();
    await FirebaseFirestore.instance
        .collection('scores')
        .doc(player.id)
        .delete();
  }
}
