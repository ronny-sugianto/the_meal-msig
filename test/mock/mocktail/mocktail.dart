import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:msig_food/src/src.dart';

/// Cubits
class MockMessageCubit extends MockCubit<Message?> implements MessageCubit {}

class MockCategoryCubit extends MockCubit<BaseState<List<String>>>
    implements CategoryCubit {}

class MockMealDataCubit extends MockCubit<BaseState<List<Meal>>>
    implements MealDataCubit {}

class MockMealActionCubit extends MockCubit<BaseState<Meal>>
    implements MealActionCubit {}

class MockFavoriteDataCubit extends MockCubit<BaseState<List<FavoriteData>>>
    implements FavoriteDataCubit {}

class MockFavoriteActionCubit extends MockCubit<BaseState>
    implements FavoriteActionCubit {}

/// Fakes
class FakeBaseState extends Fake implements BaseState {}
