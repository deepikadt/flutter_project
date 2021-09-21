import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:product_hunt_app/models/post_model.dart';
import 'package:product_hunt_app/services/db_service/db_constants.dart';
import 'package:product_hunt_app/utils/global.dart';
import 'package:sqflite/sqflite.dart';

abstract class AppDatabaseBase {
  addProductData(PostModel productDetail);
  fetchProductData();
  clearData();
}

class AppDatabase implements AppDatabaseBase {
  Database _db;

  static const _databaseName = "ProductHunt.db";
  static const _databaseVersion = 1;

  static AppDatabase _appDatabase;

  //named constructor
  AppDatabase._createInstance();

  factory AppDatabase() {
    _appDatabase = _appDatabase ?? AppDatabase._createInstance();

    return _appDatabase;
  }

  Future<Database> get database async {
    _db = _db ?? await initDatabase();

    return _db;
  }

  Future<Database> initDatabase() async {
    //get directory path for andorid and ios to store database
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'ProductHunt', _databaseName);

    //open or create db at a given path
    var database = await openDatabase(path,
        version: _databaseVersion, onCreate: _createDb, onUpgrade: _onUpgrade);

    return database;
  }

  Future<void> closeDB() async {
    if (_db != null) await _db.close();
    _db = null;
  }

  /// get db file
  Future<File> getFile() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'ProductHunt', _databaseName);

    if (await databaseExists(path)) {
      return File(path);
    }

    return null;
  }

  /// set db file
  Future<void> setFile(List<int> bytes) async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'ProductHunt', _databaseName);
    File(path).writeAsBytesSync(bytes);
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('CREATE TABLE ${DbConstants.tableProductHunt}'
        '(${DbConstants.colId} INTEGER PRIMARY KEY AUTOINCREMENT,'
        '${DbConstants.colName} STRING,'
        '${DbConstants.colTagline} STRING ,'
        '${DbConstants.colImageUrl} STRING)');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await db.execute('DROP TABLE IF EXISTS ${DbConstants.tableProductHunt}');

    _createDb(db, newVersion);
  }

  @override
  addProductData(PostModel products) async {
    await database;
    try {
      for (var data in products.posts) {
        Map<String, Object> map = {
          DbConstants.colId: data.id,
          DbConstants.colName: data.name,
          DbConstants.colTagline: data.tagline,
          DbConstants.colImageUrl: data.thumbnail.imageUrl,
        };
        await _db.insert(DbConstants.tableProductHunt, map);
      }
    } catch (e) {
      printDebug(e);
    }
  }

  @override
  fetchProductData() async {
    await database;
    try {
      List<Map<String, Object>> data =
          await _db.query(DbConstants.tableProductHunt);

      PostModel postModel = PostModel();

      List<Post> _posts = [];

      data.forEach((element) {
        Post model = Post.fromJsonForDb(element);
        _posts.add(model);
      });

      postModel.posts = _posts;

      return postModel;
    } catch (e) {
      printDebug(e);
    }
  }

  @override
  clearData() async {
    await database;
    try {
      await _db.delete(DbConstants.tableProductHunt);
    } catch (e) {
      printDebug(e);
    }
  }
}
