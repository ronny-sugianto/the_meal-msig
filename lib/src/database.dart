import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:msig_food/src/common/common.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

@DriftDatabase(tables: [Favorite])
class Database extends _$Database {
  Database() : super(openConnection());

  // Named constructor for creating in-memory database
  Database.forTesting(super.e);

  @override
  int get schemaVersion => 1;

  Future<List<FavoriteData>> getFavorites() async =>
      await select(favorite).get();

  Future<FavoriteData> getFavorite(String id) async =>
      await (select(favorite)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<int> insertFavorite(FavoriteCompanion favoriteData) async =>
      await into(favorite).insert(favoriteData);

  Future<int> deleteFavorite(String id) async =>
      await (delete(favorite)..where((tbl) => tbl.id.equals(id))).go();
}

LazyDatabase openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(path.join(dbFolder.path, 'favorite.db'));

    return NativeDatabase.createBackgroundConnection(file);
  });
}
