// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:logging/logging.dart' hide Level;
import 'package:provider/provider.dart';

import '../src.dart';

class PlaaySessionScreen extends StatefulWidget {
  final GameLevel level;
  const PlaaySessionScreen({super.key, required this.level});

  @override
  State<PlaaySessionScreen> createState() => _PlaaySessionScreenState();
}

class _PlaaySessionScreenState extends State<PlaaySessionScreen> {
  // static final _log = Logger('PlaySessionScreen');

  // static const _celebrationDuration = Duration(milliseconds: 2000);

  // static const _preCelebrationDuration = Duration(milliseconds: 500);

  final _image = GameConstant.images;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CountdownModel>(context, listen: false).startTimer(5);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    // final palette = context.watch<Palette>();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LevelState(
            goal: widget.level.difficulty,
            onWin: () {},
          ),
        ),
      ],
      child: Scaffold(
        body: SafeArea(
          child: Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(
                  _image.backgroundImage,
                ),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Consumer<CountdownModel>(
                  builder: (context, model, _) {
                    int minutes = (model.secondsRemaining / 60).truncate();
                    int seconds = model.secondsRemaining % 60;

                    return Text(
                      '$minutes:${seconds.toString().padLeft(2, '0')}',
                      style: TextStyle(fontSize: 48),
                    );
                  },
                ),
                Consumer<CountdownModel>(
                  builder: (context, model, child) {
                    return SizedBox(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () => model
                              ..restartTimer(5)
                              ..startTimer(5),
                            icon: Icon(Icons.restart_alt, size: 50),
                          ),
                          IconButton(
                            onPressed: () => model.pauseTimer(),
                            icon: Icon(Icons.pause, size: 50),
                          ),
                          IconButton(
                            onPressed: () => model.resumeTimer(),
                            icon: Icon(
                              Icons.play_arrow,
                              size: 50,
                            ),
                          ),
                          IconButton(
                            onPressed: () => model.stopTimer(),
                            icon: Icon(
                              Icons.stop,
                              size: 50,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
