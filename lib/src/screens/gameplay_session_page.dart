// import 'dart:async';

import 'package:flutter/material.dart';

// import 'package:logging/logging.dart' hide Level;
import 'package:provider/provider.dart';

import 'package:word_rush/src/logic/logic.dart';
import 'package:word_rush/src/screens/widgets/pan_custom_paint.dart';
import 'package:word_rush/src/screens/widgets/play_session_appbar.dart';

import '../src.dart';

class PlaaySessionScreen extends StatefulWidget {
  final GameLevel level;
  const PlaaySessionScreen({super.key, required this.level});

  @override
  State<PlaaySessionScreen> createState() => _PlaaySessionScreenState();
}

class _PlaaySessionScreenState extends State<PlaaySessionScreen> {
  final _image = GameConstant.images;

  String gameWord = '';

  @override
  void initState() {
    super.initState();
    Provider.of<CountdownModel>(context, listen: false).startTimer(5);
    gameWord = Provider.of<GameLogic>(context, listen: false).gameWord();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Provider.of<CountdownModel>(context).dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final palette = context.watch<Palette>();

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
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: playSessionAppBar(context, size, palette, _image),
                ),
                Container(
                  height: 450,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(_image.settingBoard),
                    ),
                  ),
                ),
                Container(
                  height: 250,
                  width: 250,
                  child: CustomPaint(
                    isComplex: true,
                    willChange: true,
                    painter: WordCookiePainter(
                        letters: gameWord.toUpperCase().split('')),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
