import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:word_rush/src/src.dart';

class GameRoutes {
  static final routes = GoRouter(
    initialLocation: RoutePath.home,
    routes: [
      GoRoute(
        path: RoutePath.home,
        name: RouteNames.home,
        builder: (context, state) {
          return const HomePage('HomePage');
        },
        routes: [
          GoRoute(
              path: RoutePath.mainMenu,
              name: RouteNames.mainMenu,
              pageBuilder: (context, state) {
                return buildMyTransition(
                    child: MainMenu(),
                    color: context.watch<Palette>().btnColor);
              },
              routes: [
                GoRoute(
                  path: RoutePath.settings,
                  name: RouteNames.settings,
                  pageBuilder: (context, state) {
                    return buildMyTransition(
                        child: SettingsPage(),
                        color: context.watch<Palette>().btnColor);
                  },
                )
              ]),
        ],
      ),
    ],
  );
}
