import 'dart:io';

import 'package:flutter/foundation.dart';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
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

  _log.info('Going full screen');
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );

  AdManager? _admanager;

  if (!kIsWeb && (Platform.isIOS || Platform.isAndroid)) {
    _admanager = AdManager();
    await _admanager.initialize();
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
    ),
  );
}

class MyApp extends StatelessWidget {
  final PlayerProgressPersistence playerProgressPersistence;

  final SettingsPersistence settingsPersistence;

  final GamesServicesController? gamesServicesController;
  final AdManager? admanager;
  const MyApp(
      {super.key,
      required this.playerProgressPersistence,
      required this.settingsPersistence,
      this.gamesServicesController,
      this.admanager});

  @override
  Widget build(BuildContext context) {
    final _router = GameRoutes.routes;

    return AppLifecycleObserver(
        child: MultiProvider(
      providers: [
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
            Future.delayed(
              const Duration(seconds: 5),
            );
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
        return MaterialApp.router(
          title: 'Flutter Demo',
          theme: ThemeData.from(
            colorScheme: ColorScheme.fromSeed(
              seedColor: palette.darkPen,
              background: palette.backgroundMain,
            ),
            textTheme: TextTheme(
              bodyMedium: TextStyle(
                color: palette.ink,
              ),
            ),
            useMaterial3: true,
          ),
          routeInformationParser: _router.routeInformationParser,
          routerDelegate: _router.routerDelegate,
          scaffoldMessengerKey: scaffoldMessengerKey,
        );
      }),
    ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await AdManager.preloadInterstitialAd();
      await AdManager.preloadRewardedAds();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              onPressed: () async {
                await AdManager.showInterstitialAd();
              },
              tooltip: 'Increment',
              child: const Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: () async {
                await AdManager.showRewardedAds();
              },
              tooltip: 'Increment',
              child: const Icon(Icons.remove),
            ),
          ],
        ));
  }
}
