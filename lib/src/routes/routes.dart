import 'package:go_router/go_router.dart';
import 'package:word_rush/main.dart';
import 'package:word_rush/src/routes/routing_paths.dart';

import 'routing_names.dart';

class GameRoutes {
  static final routes = GoRouter(
    initialLocation: RoutePath.home,
    routes: [
      // GoRoute(
      //   path: RoutePath.splash,
      //   name: RouteNames.splash,
      //   builder: (context, state) {
      //     return SplashScreen();
      //   },
      // ),
      GoRoute(
        path: RoutePath.home,
        name: RouteNames.home,
        builder: (context, state) {
          return MyHomePage(title: 'Hello World');
        },
      ),
    ],
  );
}
