import 'package:firebase_auth/firebase_auth.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// A class that initializes the local database.
class LocalDatabase {
  /// Returns the instance of the local database.
  factory LocalDatabase() => _instance;
  LocalDatabase._internal();
  static final _instance = LocalDatabase._internal();
  static const _databaseName = 'app_database.db';
  static const _databaseVersion = 1;

  /// The table name.
  static const tableName = 'dynamic_bounce';

  /// The column name for the user id.
  static const columnUserId = 'userId';

  /// The column name for the best score.
  static const columnBestScore = 'bestScore';

  Database? _database;

  /// Returns the database.
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  /// Initializes the database.
  Future<Database> _initDatabase() async {
    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, _databaseName);
      final auth = FirebaseAuth.instance;
      final userId = auth.currentUser!.uid;
      return openDatabase(
        path,
        version: _databaseVersion,
        onCreate: (db, _) async {
          await db.execute('''
          CREATE TABLE $tableName (
            $columnUserId TEXT PRIMARY KEY,
            $columnBestScore INTEGER NOT NULL
          )
        ''');
          // Insert a record for the initial user.
          await db.insert(
            tableName,
            {
              columnUserId: userId,
              columnBestScore: 0,
            },
          );
        },
      );
    } catch (e) {
      throw Exception('Failed to initialize the database $e');
    }
  }

  /// Closes the database.
  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
    }
  }
}
