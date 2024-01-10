import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:msig_food/src/src.dart';

import '../../../test/mock/mock.dart';
import '../../helper/helper.dart';

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

  final mealRepository = MockBaseTheMealRepository();

  List<Meal> meals = [
    Meal(
      id: 'xxx1',
      name: 'Item A',
      thumbnail:
          'https://i.ytimg.com/vi/STyzwvzWfsg/hqdefault.jpg?sqp=-oaymwEbCKgBEF5IVfKriqkDDggBFQAAiEIYAXABwAEG&rs=AOn4CLBetEH2MmiX7riaA4bzyZM1Dmllgg',
    ),
  ];

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
        BlocProvider<FavoriteActionCubit>.value(
            value: MockFavoriteActionCubit()),
        BlocProvider<FavoriteDataCubit>.value(value: MockFavoriteDataCubit())
      ],
      repositoryProviders: [
        RepositoryProvider<BaseTheMealRepository>.value(value: mealRepository),
      ],
    );
  }

  group('home_integration_test.dart', () {
    group('Given: Normal flow', () {
      testWidgets(
          'When: User change category - Then: Home screen loaded successfully with data',
          (WidgetTester tester) async {
        await mockNetworkImages(() async {
          // Stub function on CategoryCubit
          when(mealRepository.getCategory()).thenAnswer(
            (_) => Future.value(["Breakfast", "Food", "Burger"]),
          );

          // Stub function on MealDataCubit
          when(mealRepository.getMeal(category: "breakfast")).thenAnswer(
            (_) => Future.value(meals),
          );

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
        });
      });

      testWidgets(
          'When: User change category - Then: Home screen loaded successfully with empty data',
          (WidgetTester tester) async {
        await mockNetworkImages(() async {
          // Stub function on CategoryCubit
          when(mealRepository.getCategory()).thenAnswer(
            (_) => Future.value(["Breakfast", "Food", "Burger"]),
          );

          // Stub function on MealDataCubit
          when(mealRepository.getMeal(category: "breakfast")).thenAnswer(
            (_) => Future.value([]),
          );
          // Stub function on MealDataCubit
          when(mealRepository.getMeal(category: "breakfast")).thenAnswer(
            (_) => Future.value([]),
          );

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

          expect(find.byKey(const Key(UIKeys.mealListEmpty)), findsOneWidget);

          await tester.pump(const Duration(microseconds: 250));
        });
      });

      testWidgets(
          'When: User change category - Then: Home screen loaded unsuccessfully with error',
          (WidgetTester tester) async {
        await mockNetworkImages(() async {
          // Stub function on CategoryCubit
          when(mealRepository.getCategory()).thenAnswer(
            (_) => Future.value(["Breakfast", "Food", "Burger"]),
          );

          // Stub function on MealDataCubit
          when(mealRepository.getMeal(category: "breakfast"))
              .thenThrow(Exception());

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

          expect(find.byKey(const Key(UIKeys.mealListError)), findsOneWidget);

          await tester.pump(const Duration(microseconds: 250));
        });
      });
    });
  });
}
