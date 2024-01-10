import 'package:drift/drift.dart';
import 'package:msig_food/src/common/common.dart';
import 'package:msig_food/src/database.dart';

class Favorite extends Table {
  TextColumn get id => text()();
  TextColumn get thumbnail => text()();
  TextColumn get name => text()();
  DateTimeColumn get date => dateTime()();
}

Meal favoriteToMeal(FavoriteData favoriteData) => Meal(
    id: favoriteData.id,
    name: favoriteData.name,
    thumbnail: favoriteData.thumbnail);
