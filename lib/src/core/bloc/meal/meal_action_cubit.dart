import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msig_food/src/src.dart';

class MealActionCubit extends Cubit<BaseState<Meal>> {
  final BaseTheMealRepository mealRepository;
  MealActionCubit({
    required this.mealRepository,
  }) : super(InitializedState());

  void getMealDetail({
    required String mealId,
  }) async {
    emit(LoadingState());

    Meal? meal;

    /// Get Meal Detail
    try {
      meal = await mealRepository.getMealDetail(mealId: mealId);
      if (meal == null) throw Exception();
    } catch (e) {
      return emit(ErrorState(error: '$e'));
    }

    emit(SuccessState(data: meal));
  }
}
