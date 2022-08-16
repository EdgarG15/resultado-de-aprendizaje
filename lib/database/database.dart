import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'contacts.dart';

class SqliteDB {
  static Future<Database> _openDB() async {
    return openDatabase(join(await getDatabasesPath(), 'contacts.db'),
        onCreate: (db, version) {
      return db.execute(
        "CREATE TABLE contacts (id INTEGER PRIMARY KEY, name TEXT, lastname TEXT, phoneNumber TEXT)",
      );
    }, version: 1);
  }

  static Future<Future<int>> insert(Contact contact) async {
    Database database = await _openDB();

    return database.insert("contacts", contact.toMap());
  }

  static Future<Future<int>> delete(Contact contact) async {
    Database database = await _openDB();

    return database
        .delete("contacts", where: "id = ?", whereArgs: [contact.id]);
  }

  static Future<Future<int>> update(Contact contact) async {
    Database database = await _openDB();

    return database.update("contacts", contact.toMap(),
        where: "id = ?", whereArgs: [contact.id]);
  }

  static Future<List<Contact>> contacts() async {
    Database database = await _openDB();
    final List<Map<String, dynamic>> contactsMap =
        await database.query("contacts");

    return List.generate(
        contactsMap.length,
        (i) => Contact(
            id: contactsMap[i]['id'],
            name: contactsMap[i]['name'],
            lastname: contactsMap[i]['lastname'],
            phoneNumber: contactsMap[i]['phoneNumber']));
  }
}
