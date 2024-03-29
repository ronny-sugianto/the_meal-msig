import 'package:alice/alice.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:msig_food/app_widget.dart';
import 'package:msig_food/src/src.dart';

import '../../test/mock/mock.dart';

class Helper {
  Future<void> pumpApp(
    WidgetTester tester, {
    List<BlocProvider>? blocProviders,
    List<RepositoryProvider>? repositoryProviders,
  }) async =>
      await tester.pumpWidget(
        MultiBlocProvider(
          providers: [
            BlocProvider<MessageCubit>.value(value: MockMessageCubit()),
            ...?blocProviders
          ],
          child: MultiRepositoryProvider(
            providers: [
              RepositoryProvider(create: (_) => Alice()),
              RepositoryProvider(create: (_) => MockBaseApiClient()),
              ...?repositoryProviders
            ],
            child: const MainApp(),
          ),
        ),
      );
}
