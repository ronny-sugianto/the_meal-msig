import 'package:alice/alice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msig_food/src/src.dart';

import 'app_route.dart';

class InitializeApp extends StatelessWidget {
  final Alice alice;
  final BaseDriftClient driftClient;
  final BaseApiClient apiClient;
  final BaseTheMealRepository theMealRepository;
  final BaseFavoriteRepository favoriteRepository;

  const InitializeApp({
    super.key,
    required this.alice,
    required this.driftClient,
    required this.apiClient,
    required this.theMealRepository,
    required this.favoriteRepository,
  });

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MessageCubit(),
          ),
          BlocProvider(
            create: (context) =>
                FavoriteActionCubit(favoriteRepository: favoriteRepository),
          ),
          BlocProvider(
            create: (context) =>
                FavoriteDataCubit(favoriteRepository: favoriteRepository),
          )
        ],
        child: MultiRepositoryProvider(
          providers: [
            RepositoryProvider(create: (context) => alice),
            RepositoryProvider(create: (context) => driftClient),
            RepositoryProvider(create: (context) => apiClient),
            RepositoryProvider(create: (context) => theMealRepository),
            RepositoryProvider(create: (context) => favoriteRepository),
          ],
          child: const MainApp(),
        ),
      );
}

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> with WidgetsBindingObserver {
  final AppRouter _appRouter = AppRouter();
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    try {
      context.read<Alice>().setNavigatorKey(_navigatorKey);
    } catch (e) {
      debugPrint('Http Inspector is not implemented: $e');
    }
  }

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: _navigatorKey,
        initialRoute: RouteName.homeScreen,
        onGenerateRoute: _appRouter.onGenerateRoute,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.redAccent,
        ),
        builder: (context, child) => BlocListener<MessageCubit, Message?>(
            listener: (context, message) {
              if (message != null && _navigatorKey.currentContext != null) {
                ScaffoldMessenger.of(_navigatorKey.currentContext!)
                    .showSnackBar(
                  SnackBar(
                    content: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                        vertical: 10,
                      ),
                      color: Color(
                        message.isError == true ? 0xFFF15334 : 0xFF4C9540,
                      ),
                      child: Text(
                        message.message ?? '-',
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                    elevation: 0,
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(seconds: 3),
                    padding: const EdgeInsets.all(0),
                    margin: message.margin ??
                        const EdgeInsets.only(
                          left: 0,
                          right: 0,
                        ),
                  ),
                );
              }
            },
            child: child!),
      );
}