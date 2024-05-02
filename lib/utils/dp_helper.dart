import 'dart:io';

import 'package:budget_app/screen/categrry/model/category_model.dart';
import 'package:budget_app/screen/transation/model/transation_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static DBHelper helper = DBHelper._();
  DBHelper._();

  Database? database;

  Future<Database>? checkdb() async {
    if (database != null) {
      return database!;
    } else {
      return await initdb();
    }
  }

  Future<Database> initdb() async {
    Directory directory = await getApplicationSupportDirectory();
    String path = join(directory.path, "rutvik.dp");
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String transationQuery =
            "CREATE TABLE transation (id INTEGER PRIMARY KEY AUTOINCREMENT,amount TEXT,status INTEGER,date TEXT,time TEXT,category TEXT,title TEXT)";
        String categrryQueruy =
            "CREATE TABLE category(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT)";
        db.execute(transationQuery);
        db.execute(categrryQueruy);
      },
    );
  }

  Future<void> insertcategory(String name) async {
    database = await checkdb();
    database!.insert("category", {"name": name});
  }
  Future<List<categoryModel>> readcategory()
  async {
    database = await checkdb();
    String category="SELECT * FROM category";
    List<Map> list =await database!.rawQuery(category);
    List<categoryModel> l1=list.map((e) => categoryModel.mapToModel(e)).toList();
    return l1;
  }
  void deletcategory(int id)
  async {
    database = await checkdb();
    database!.delete("category",where: "id=?",whereArgs: [id]);
  }
  void  updatecategory(String name,int id)
  async {
    database = await checkdb();
    database!.update("category", {"name": "$name"},where: "id=?",whereArgs: [id]);

  }
  Future<void> trasactioninsert(TrasacationModel model)
  async {
    database = await checkdb();
    database!.insert("transation", {"title":"${model.title}","amount":"${model.amount}","date":"${model.date}","time":"${model.time}","category":"${model.category}","status":"${model.status}"});
  }
  Future<List<TrasacationModel>> readTrasaction()
  async {
    database = await checkdb();
    String transation="SELECT * FROM transation";
    List<Map> list =await database!.rawQuery(transation);
    List<TrasacationModel> l1=list.map((e) => TrasacationModel.mapToModel(e)).toList();
    return l1;
  }
  void transactiondelet(int id)
  async {
    database = await checkdb();
    database!.delete("transation",where: "id=?",whereArgs: [id]);
  }
  void  transactionupdate(TrasacationModel model)
  async {
    database = await checkdb();
    database!.update("transation", {"title":"${model.title}","amount":"${model.amount}","date":"${model.date}","time":"${model.time}","category":"${model.category}","status":"${model.status}"},where: "id=?",whereArgs: [model.id]);

  }
}

