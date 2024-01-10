part of 'base_favorite_repository.dart';

class FavoriteRepository extends BaseFavoriteRepository {
  final BaseDriftClient driftClient;
  FavoriteRepository({required this.driftClient});

  @override
  Future<int> deleteFavorite(String id) async =>
      await driftClient.deleteFavorite(id);

  @override
  Future<FavoriteData> getFavorite(String id) async =>
      await driftClient.getFavorite(id);

  @override
  Future<List<FavoriteData>> getFavorites() async =>
      await driftClient.getFavorites();

  @override
  Future<int> insertFavorite(FavoriteCompanion favoriteData) async =>
      driftClient.insertFavorite(favoriteData);
}
