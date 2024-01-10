import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mocktail/mocktail.dart' as mocktail;
import 'package:msig_food/src/src.dart';

import '../../../test/mock/mock.dart';
import '../../../test/mock/mockito/repository/favorite/base_favorite_repository.mocks.dart';
import '../../helper/helper.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  final mealRepository = MockBaseTheMealRepository();

  late MockFavoriteActionCubit favoriteActionCubit;

  final favoriteRepository = MockBaseFavoriteRepository();

  setUpAll(() => mocktail.registerFallbackValue(FakeBaseState()));

  setUp(() {
    favoriteActionCubit = MockFavoriteActionCubit();
    when(favoriteActionCubit.state).thenReturn(SuccessState(data: true));
  });

  Meal meal = Meal(
    id: 'xxx1',
    name: 'Item A',
    category: 'Breakfast',
    measureIngredient: ["1gr salt"],
    instruction: 'Hello World',
    thumbnail:
        'https://i.ytimg.com/vi/STyzwvzWfsg/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLBetEH2MmiX7riaA4bzyZM1Dmllgg',
  );

  FavoriteData favoriteData = FavoriteData(
    id: 'xxx1',
    name: 'Item A',
    thumbnail:
        'https://i.ytimg.com/vi/STyzwvzWfsg/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLBetEH2MmiX7riaA4bzyZM1Dmllgg',
    date: DateTime.now(),
  );

  Future<void> pumpApp(WidgetTester tester) async {
    await Helper().pumpApp(
      tester,
      blocProviders: [
        BlocProvider<CategoryCubit>.value(
          value: MockCategoryCubit()..getCategoryList(),
        ),
        BlocProvider<MealDataCubit>.value(
          value: MockMealDataCubit(),
        ),
        BlocProvider<MealActionCubit>.value(
          value: MockMealActionCubit(),
        ),
        BlocProvider<FavoriteActionCubit>.value(
          value: favoriteActionCubit..getFavoriteById(meal.id ?? '-'),
        ),
        // BlocProvider<FavoriteDataCubit>.value(
        //   value: MockFavoriteDataCubit(),
        // )
      ],
      repositoryProviders: [
        RepositoryProvider<BaseTheMealRepository>.value(value: mealRepository),
        RepositoryProvider<BaseFavoriteRepository>.value(
          value: favoriteRepository,
        ),
      ],
    );
  }

  group('detail_integration_test.dart', () {
    group('Given: Normal flow', () {
      testWidgets(
          'When: User navigate to detail - Then: loaded successfully with data',
          (WidgetTester tester) async {
        await mockNetworkImages(() async {
          // Stub function on CategoryCubit
          when(mealRepository.getCategory()).thenAnswer(
            (_) => Future.value(["Breakfast", "Food", "Burger"]),
          );

          // Stub function on MealDataCubit
          when(mealRepository.getMeal(category: "breakfast")).thenAnswer(
            (_) => Future.value([meal]),
          );

          // Stub function on MealDataCubit
          when(mealRepository.getMealDetail(mealId: "xxx1")).thenAnswer(
            (_) => Future.value(meal),
          );

          // Stub function on FavoriteActionCubit
          when(favoriteRepository.getFavorite(meal.id))
              .thenAnswer((_) async => favoriteData);

          when(favoriteRepository.insertFavorite(FavoriteCompanion(
            id: drift.Value(favoriteData.id),
            name: drift.Value(favoriteData.name),
            thumbnail: drift.Value(favoriteData.thumbnail),
            date: drift.Value(favoriteData.date),
          ))).thenAnswer((_) async => 1);

          when(favoriteRepository.deleteFavorite(meal.id))
              .thenAnswer((_) async => 1);

          await pumpApp(tester);
          await tester.pumpAndSettle();

          // Home screen successfully loaded
          expect(find.byType(HomeScreen), findsOneWidget);

          // Tap Dropdown Category
          await tester.tap(find.byKey(const Key(UIKeys.categoryDropdown)));
          await tester.pump(const Duration(milliseconds: 250));

          await tester.tap(
            find.bySemanticsLabel(
              RegExp(
                '${UIKeys.categoryItem('Breakfast')}',
                caseSensitive: false,
              ),
            ),
          );

          await tester.pump(const Duration(milliseconds: 250));

          await tester.tap(find.byKey(Key(UIKeys.mealItem(0))));
          await tester.pump(const Duration(milliseconds: 2500));

          await expectLater(find.byType(DetailScreen), findsOneWidget);
          await tester.pump(const Duration(microseconds: 3500));

          // Screen
          expect(find.byKey(const Key(UIKeys.detailScreen)), findsOneWidget);

          // // List View when Success
          // expect(find.byKey(const Key(UIKeys.detailListView)), findsOneWidget);
          // await tester.pump(const Duration(microseconds: 2500));
          //
          // await tester.tap(find.byKey(const Key(UIKeys.appBarBack)));
          // await tester.pump(const Duration(milliseconds: 2500));
          //
          // await expectLater(find.byType(HomeScreen), findsOneWidget);
        });
      });
    });
  });
}
