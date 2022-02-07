import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQLHelper {
  //Function to create database
  static Future<void> createTable(sql.Database database) async {
    await database.execute("""CREATE TABLE items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        title TEXT,
        description TEXT,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
      """);
  }

  //Function to open database
  static Future<sql.Database> db() async {
    return sql.openDatabase('application.db', version: 1,
        onCreate: (sql.Database database, int version) async {
      await createTable(database);
    });
  }

  //Here starts the four operations create,get/read,update,delete

  //Function to createItem
  static Future<int> createItem(String title, String description) async {
    final db = await SQLHelper.db();
    final data = {
      'title': title,
      'description': description,
    };
    final id = await db.insert(
      'items',
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
    return id;
  }
  static Future<List<Map<String, dynamic>>> getItem(int id) async {
    final db = await SQLHelper.db();
    return db.query('items', where: "id = ?", whereArgs: [id], limit: 1);
  }

  //Function to getItem
  static Future<List<Map<String, dynamic>>> getItems() async {
    final db = await SQLHelper.db();
    return db.query('items', orderBy: 'id');
  }

  //Function to updateItem
  static Future<int> updateItem(
      int id, String title, String? description) async {
    final db = await SQLHelper.db();
    final data = {
      'title': title,
      'description': description,
      'createdAt': DateTime.now().toString(),
    };
    final result =
        await db.update('items', data, where: " id = ?", whereArgs: [id]);
    return result;
  }

  //Function to deleteItem
  static Future<void> deleteItem(int id) async {
    final db = await SQLHelper.db();
    try {
      await db.delete('items', where: " id = ?", whereArgs: [id]);
    } catch (err) {
      debugPrint("Something went wrong $err");
    }
  }
}
