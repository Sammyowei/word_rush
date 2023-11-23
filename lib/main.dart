import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:word_rush/firebase_options.dart';
import 'package:word_rush/src/logic/logic.dart';

import 'src/src.dart';

final _log = Logger('main.dart');
Future<void> main() async {
  Logger.root.onRecord.listen((record) {
    dev.log(
      record.message,
      time: record.time,
      level: record.level.value,
      name: record.loggerName,
      zone: record.zone,
      error: record.error,
      stackTrace: record.stackTrace,
    );
  });
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: To enable Firebase Crashlytics, uncomment the following line.
  // See the 'Crashlytics' section of the main README.md file for details.

  if (!kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );

      FlutterError.onError = (errorDetails) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      };

      // Pass all uncaught asynchronous errors
      // that aren't handled by the Flutter framework to Crashlytics.
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };
    } catch (e) {
      debugPrint("Firebase couldn't be initialized: $e");
    }
  }

  _log.info('Going full screen');
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  AdManager? _admanager;

  if (!kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
    _admanager = AdManager();
    await _admanager.initialize();
  }

  GameLogic? _logic;
  if (!kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
    _logic = GameLogic()
      // Attempt to log the player in.
      ..initialize();
  }
  GamesServicesController? gamesServicesController;
  if (!kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
    gamesServicesController = GamesServicesController()
      // Attempt to log the player in.
      ..initialize();
  }

  runApp(
    MyApp(
      settingsPersistence: LocalStorageSettingsPersistence(),
      playerProgressPersistence: LocalStoragePlayerProgressPersistence(),
      admanager: _admanager,
      gamesServicesController: gamesServicesController,
      logic: _logic,
    ),
  );
}

class MyApp extends StatelessWidget {
  final PlayerProgressPersistence playerProgressPersistence;

  final SettingsPersistence settingsPersistence;

  final GamesServicesController? gamesServicesController;
  final AdManager? admanager;
  final GameLogic? logic;
  const MyApp(
      {super.key,
      required this.playerProgressPersistence,
      required this.settingsPersistence,
      this.gamesServicesController,
      this.logic,
      this.admanager});

  @override
  Widget build(BuildContext context) {
    return AppLifecycleObserver(
        child: MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GameLogic()..initialize(),
        ),
        ChangeNotifierProvider(
          create: (context) => CountdownModel(),
        ),
        ChangeNotifierProvider(
          create: (context) {
            var progress = PlayerProgress(playerProgressPersistence);
            progress.getLatestFromStore();
            return progress;
          },
        ),
        Provider<GamesServicesController?>.value(
            value: gamesServicesController),
        Provider<AdManager?>.value(value: admanager),
        Provider<SettingsController>(
          lazy: false,
          create: (context) => SettingsController(
            persistence: settingsPersistence,
          )..loadStateFromPersistence(),
        ),
        ProxyProvider2<SettingsController, ValueNotifier<AppLifecycleState>,
            AudioController>(
          // Ensures that the AudioController is created on startup,
          // and not "only when it's needed", as is default behavior.
          // This way, music starts immediately.
          lazy: false,
          create: (context) => AudioController()..initialize(),
          update: (context, settings, lifecycleNotifier, audio) {
            if (audio == null) throw ArgumentError.notNull();
            audio.attachSettings(settings);
            audio.attachLifecycleNotifier(lifecycleNotifier);

            return audio;
          },
          dispose: (context, audio) => audio.dispose(),
        ),
        Provider(
          create: (context) => Palette(),
        ),
      ],
      child: Builder(builder: (context) {
        final palette = context.watch<Palette>();
        final routes = GameRoutes.routes;
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          routerConfig: RouterConfig(
            routerDelegate: routes.routerDelegate,
            routeInformationParser: routes.routeInformationParser,
            routeInformationProvider: routes.routeInformationProvider,
          ),
          theme: ThemeData.from(
            colorScheme: ColorScheme.fromSeed(
              seedColor: palette.darkPen,
              // background: palette.backgroundMain,
            ),
            textTheme: TextTheme(
              bodyMedium: TextStyle(
                color: palette.ink,
              ),
            ),
            useMaterial3: true,
          ),
          // routeInformationParser: routes.routeInformationParser,
          // routerDelegate: routes.routerDelegate,
          scaffoldMessengerKey: scaffoldMessengerKey,
        );
      }),
    ));
  }
}
