import 'package:alice/alice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msig_food/src/src.dart';

import 'app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Alice alice = Alice(
    showNotification: true,
  );

  /// Initialize Clients
  BaseApiClient apiClient = ApiClient(
    alice: alice,
  );

  BaseDriftClient driftClient = DriftClient(database: Database());

  /// Initialize Repositories
  BaseTheMealRepository theMealRepository = TheMealRepository(
    apiClient: apiClient,
  );
  BaseFavoriteRepository favoriteRepository = FavoriteRepository(
    driftClient: driftClient,
  );

  Bloc.observer = MainBlocObserver();

  runApp(
    InitializeApp(
      alice: alice,
      driftClient: driftClient,
      apiClient: apiClient,
      theMealRepository: theMealRepository,
      favoriteRepository: favoriteRepository,
    ),
  );
}
