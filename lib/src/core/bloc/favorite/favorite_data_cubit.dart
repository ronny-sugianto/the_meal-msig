import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msig_food/src/src.dart';

class FavoriteDataCubit extends Cubit<BaseState<List<FavoriteData>>> {
  final BaseFavoriteRepository favoriteRepository;
  FavoriteDataCubit({required this.favoriteRepository})
      : super(InitializedState());

  void initialize() async {
    emit(LoadingState());
    List<FavoriteData> favorites = [];
    try {
      favorites = await favoriteRepository.getFavorites();
      if (favorites.isEmpty) return emit(EmptyState());
    } catch (e) {
      return emit(ErrorState(error: '$e'));
    }

    emit(LoadedState(data: favorites));
  }

  void update(List<FavoriteData> favorites) => emit(
        LoadedState(
          data: favorites,
          timestamp: DateTime.now(),
        ),
      );
}
