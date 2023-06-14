import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'User.dart';

class DatabaseHelper {
//创建数据库和表
  Future<Database> get database async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'user.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE user(id INTEGER PRIMARY KEY, email TEXT, password TEXT)",
        );
      },
      version: 1,
    );
  }

  //插入数据
  Future<void> insertUser(User user) async {
    final db = await database;

    await db.insert(
      'user',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
//  查询所有数据
  Future<List<User>> users() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('user');

    return List.generate(maps.length, (i) {
      return User.fromMap(maps[i]);
    });
  }

  //更新数据
  Future<void> updateUser(User user) async {
    final db = await database;

    await db.update(
      'user',
      user.toMap(),
      where: "id = ?",
      whereArgs: [user.id],
    );
  }

//  删除数据
  Future<void> deleteUser(int id) async {
    final db = await database;

    await db.delete(
      'user',
      where: "id = ?",
      whereArgs: [id],
    );
  }

  //根据邮箱查询用户
  Future<User?> getUserByEmail(String email) async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query('user', where: "email = ?", whereArgs: [email]);

    if (maps.length > 0) {
      return User.fromMap(maps.first);
    } else {
      return null;
    }
  }
}
