import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'transaction_model.dart';

class DatabaseHelper {
  static final _databaseName = "ExpenseTracker.db";
  static final _databaseVersion = 1;

  static final table = 'transactions';

  static final columnDescription = 'description';
  static final columnAmount = 'amount';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String documentsDirectory = await getDatabasesPath();
    String path = join(documentsDirectory, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnDescription TEXT NOT NULL,
            $columnAmount FLOAT NOT NULL
          )
          ''');
  }

  Future<int> insert(TransactionModel transaction) async {
    Database db = await instance.database;
    Map<String, dynamic> row = transaction.toMap();
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<double> getAllExpenses() async {
    Database db = await instance.database;
    var result = await db.rawQuery(
        'SELECT SUM(`amount`) AS `total_expense` FROM $table WHERE `amount` < 0');
    return result.first['total_expense'];
  }

  Future<double> getAllIncomes() async {
    Database db = await instance.database;
    var result = await db.rawQuery(
        'SELECT SUM(`amount`) AS `total_income` FROM $table WHERE `amount` >= 0');
    return result.first['total_income'];
  }

  Future<double> getBalance() async {
    Database db = await instance.database;
    var result = await db
        .rawQuery('SELECT SUM(`amount`) AS `total_balance` FROM $table');
    return result.first['total_balance'];
  }

  void deleteAllRecords() async {
    Database db = await instance.database;
    await db.rawQuery('DELETE FROM $table');
  }
}
