import 'package:msig_food/src/src.dart';

part 'favorite_repository.dart';

abstract class BaseFavoriteRepository {
  Future<List<FavoriteData>> getFavorites();

  Future<FavoriteData> getFavorite(String id);

  Future<int> insertFavorite(FavoriteCompanion favoriteData);

  Future<int> deleteFavorite(String id);
}
