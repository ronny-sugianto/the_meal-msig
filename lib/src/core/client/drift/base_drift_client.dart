import 'package:mockito/annotations.dart';
import 'package:msig_food/src/src.dart';

part 'drift_client.dart';

@GenerateNiceMocks([MockSpec<BaseDriftClient>()])
abstract class BaseDriftClient {
  Future<List<FavoriteData>> getFavorites();

  Future<FavoriteData> getFavorite(String id);

  Future<int> insertFavorite(FavoriteCompanion favoriteData);

  Future<int> deleteFavorite(String id);
}
