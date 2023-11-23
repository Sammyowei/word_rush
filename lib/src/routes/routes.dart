import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:word_rush/src/src.dart';

class GameRoutes {
  static final routes = GoRouter(
    initialLocation: '/main-menu/play/session/1',
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
                  child: const MainMenu(),
                  color: context.watch<Palette>().btnColor);
            },
            routes: [
              GoRoute(
                path: RoutePath.achievements,
                name: RouteNames.achievements,
                pageBuilder: (context, state) {
                  var param;
                  final extra = state.extra;

                  if (extra is Map<String, String>) {
                    param = extra;
                  } else {
                    param = state.uri.queryParameters;
                  }

                  final header = param['header'];
                  final desc = param['desc'];
                  return DialogPage(
                    barrierDismissible: true,
                    builder: (context) {
                      return Dialog(
                        elevation: 0,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: CustomAlertDialog(
                          header: header,
                          desc: desc,
                        ),
                      );
                    },
                  );
                },
              ),
              GoRoute(
                path: RoutePath.leaderBoard,
                name: RouteNames.leaderBoard,
                pageBuilder: (context, state) {
                  var param;
                  final extra = state.extra;

                  if (extra is Map<String, String>) {
                    param = extra;
                    print('extra');
                  } else {
                    param = state.uri.queryParameters;
                    print(param);
                  }

                  final header = param['header'];
                  final desc = param['desc'];
                  return DialogPage(
                    barrierDismissible: true,
                    builder: (context) {
                      return Dialog(
                        elevation: 0,
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: CustomAlertDialog(
                          header: header,
                          desc: desc,
                        ),
                      );
                    },
                  );
                },
              ),
              GoRoute(
                path: RoutePath.settings,
                name: RouteNames.settings,
                pageBuilder: (context, state) {
                  return buildMyTransition(
                      child: const SettingsPage(),
                      color: context.watch<Palette>().btnColor);
                },
              ),
              GoRoute(
                  path: RoutePath.play,
                  name: RouteNames.play,
                  pageBuilder: (context, state) {
                    return buildMyTransition(
                        child: const LevelSelection(),
                        color: context.watch<Palette>().btnColor);
                  },
                  routes: [
                    // Game Play Session
                    GoRoute(
                      path: RoutePath.gameSession,
                      name: RouteNames.gameSession,
                      // pageBuilder: (context, state) {
                      //   final levelNumber =
                      //       int.parse(state.pathParameters['level']!);
                      //   final level = gameLevels
                      //       .singleWhere((e) => e.level == levelNumber);
                      //   return buildMyTransition<void>(
                      //     key: ValueKey('level'),
                      //     child: PlaaySessionScreen(
                      //       key: const Key('play session'),
                      //       level: level,
                      //     ),
                      //     color: context.watch<Palette>().btnColor,
                      //   );
                      // },
                      builder: (context, state) {
                        final levelNumber =
                            int.parse(state.pathParameters['level']!);
                        final level = gameLevels
                            .singleWhere((e) => e.level == levelNumber);
                        return PlaaySessionScreen(
                          key: const Key('play session'),
                          level: level,
                        );
                      },
                    ),
// Game kLevel LockedDialog
                    GoRoute(
                      path: RoutePath.levelLocked,
                      name: RouteNames.levelLocked,
                      pageBuilder: (context, state) {
                        var param;
                        final extra = state.extra;

                        if (extra is Map<String, String>) {
                          param = extra;
                          print('extra');
                        } else {
                          param = state.uri.queryParameters;
                          print(param);
                        }

                        final header = param['header'];
                        final desc = param['desc'];
                        return DialogPage(
                          barrierDismissible: true,
                          builder: (context) {
                            return Dialog(
                              elevation: 0,
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: CustomAlertDialog(
                                header: header,
                                desc: desc,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ]),
            ],
          ),
        ],
      ),
    ],
  );
}
