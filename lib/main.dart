import 'package:flutter/foundation.dart';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import 'package:word_rush/src/ads/ad_helper.dart';
import 'package:word_rush/src/ads/ads_manager.dart';
import 'package:word_rush/src/routes/routes.dart';

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

  print(defaultTargetPlatform);
  await UnityAds.init(
    gameId: AdHelper.gameID,
    onComplete: () {
      // _log.info('Unity ads has been initialised sucessfully');
      print('Unity ads has been initialized.');
    },
    onFailed: (error, errorMessage) {
      // _log.warning('Unity ads initialization failed');
      print('Unity ads failed initialized.');
    },
  );

  _log.info('Going full screen');
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final _router = GameRoutes.routes;
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
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
