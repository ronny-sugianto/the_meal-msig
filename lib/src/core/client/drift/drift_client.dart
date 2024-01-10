part of 'base_drift_client.dart';

class DriftClient extends BaseDriftClient {
  final Database database;

  DriftClient({required this.database});

  @override
  Future<int> deleteFavorite(String id) async =>
      await database.deleteFavorite(id);

  @override
  Future<FavoriteData> getFavorite(String id) async =>
      await database.getFavorite(id);

  @override
  Future<List<FavoriteData>> getFavorites() async =>
      await database.getFavorites();

  @override
  Future<int> insertFavorite(FavoriteCompanion favoriteData) async =>
      database.insertFavorite(favoriteData);
}
