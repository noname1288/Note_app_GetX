import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:test_note/model/note_model.dart';

class DatabaseService {
  //Singleton pattern
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();

  //init database
  static Database? _database;
  final tableName = 'Notes'; //chỉ tạo 1 bảng lưu note

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, tableName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''     
    CREATE TABLE $tableName (
      id INTEGER PRIMARY KEY autoincrement,
      title TEXT,
      content TEXT,
      createAt TEXT,
      updateAt TEXT,
      color TEXT
    )'''
    );
  }


  //insert a note to the {note} table
  
  Future<int> insertNote(NoteModel note) async {
    final db = await _databaseService.database;
    return await db.insert(
      tableName,
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //delete a note from the {note} table

  Future<void> deleteNote({required int id}) async {
    final db = await _databaseService.database;
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //update a note in the {note} table

  Future<void> updateNote(NoteModel note) async {
    final db = await _databaseService.database;
    await db.update(tableName, note.toMap(),
        where: 'id = ?',
        whereArgs: [note.id],
        conflictAlgorithm: ConflictAlgorithm.rollback);
  }

  // fetch all notes from the {note} table

  Future<List<NoteModel>> fetchAllNotes() async {
    final db = await _databaseService.database;
    final notes = await db.rawQuery(
        'SELECT * FROM $tableName ORDER BY createAt DESC, updateAt DESC'); //this query will return all of notes
    return notes.map((note) => NoteModel.fromSqliteDatabase(note)).toList();
  }

  // search note from the {note} table

  Future<List<NoteModel>> searchNote(String word) async {
    final db = await _databaseService.database;
    final searchingNotes = await db.query('''
     $tableName WHERE title LIKE '%$word%'
      ''');
    return searchingNotes
        .map((note) => NoteModel.fromSqliteDatabase(note))
        .toList();
  }
}
