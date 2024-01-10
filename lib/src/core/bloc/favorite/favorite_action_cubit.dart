import 'package:drift/drift.dart' as drift;
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msig_food/src/src.dart';

class FavoriteActionCubit extends Cubit<BaseState> {
  final BaseFavoriteRepository favoriteRepository;
  FavoriteActionCubit({required this.favoriteRepository})
      : super(InitializedState());

  void getFavoriteById(String id) async {
    print("======> $id");
    emit(LoadingState());
    bool isFavorite = false;

    try {
      await favoriteRepository.getFavorite(id);
      isFavorite = true;
    } catch (e) {
      debugPrint("Error while get favorite: $e");
    }

    emit(SuccessState(data: isFavorite));
  }

  void setFavoriteById(Meal data) async {
    emit(LoadingState());
    bool isFavorite = false;

    try {
      await favoriteRepository.insertFavorite(FavoriteCompanion(
        id: drift.Value(data.id ?? '-'),
        thumbnail: drift.Value(data.thumbnail ?? '-'),
        name: drift.Value(data.name ?? '-'),
        date: drift.Value(DateTime.now()),
      ));
      isFavorite = true;
    } catch (e) {
      debugPrint("Error while set favorite: $e");
    }

    emit(SuccessState(data: isFavorite));
  }

  void removeFavoriteById(String id) async {
    emit(LoadingState());
    bool isFavorite = true;

    try {
      await favoriteRepository.deleteFavorite(id);
      isFavorite = false;
    } catch (e) {
      debugPrint("Error while remove favorite: $e");
    }

    emit(SuccessState(data: isFavorite));
  }
}
