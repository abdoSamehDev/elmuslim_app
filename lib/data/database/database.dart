import 'dart:async';

import 'package:elmuslim_app/data/database/dao.dart';
import 'package:elmuslim_app/domain/models/adhkar/custom_adhkar_model.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [CustomAdhkarEntity])
abstract class AppDatabase extends FloorDatabase {
  AppDao get appDao;
}
