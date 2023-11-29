// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

// import 'package:logging/logging.dart' hide Level;
import 'package:provider/provider.dart';

import 'package:word_rush/src/logic/logic.dart';

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
  List<String> playWords = [];

  @override
  void initState() {
    super.initState();
    Provider.of<CountdownModel>(context, listen: false).startTimer(5);
    gameWord = Provider.of<GameLogic>(context, listen: false).gameWord();

    final totalWords = (widget.level.level < 5) ? 5 : widget.level.level;
    playWords = Provider.of<GameLogic>(context, listen: false).gamePlayWords(
      gameWord.split(''),
      totalWords,
    );
    print(playWords);
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
                  width: MediaQuery.sizeOf(context).width,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(_image.settingBoard),
                    ),
                  ),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 22,
                            childAspectRatio: 2.7,
                            crossAxisSpacing: 10),
                    itemCount:
                        (widget.level.level <= 5) ? 5 : widget.level.level,
                    itemBuilder: (context, gridIndex) {
                      return Container(
                        // color: Colors.blue,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: playWords[gridIndex].split('').length,
                          itemBuilder: (context, index) {
                            final letters =
                                playWords[gridIndex].split('')[index];
                            return Padding(
                              padding: const EdgeInsets.only(
                                  right: 10, top: 10, bottom: 10),
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: palette.btnColor,
                                    boxShadow: [
                                      BoxShadow(
                                        color:
                                            palette.trueWhite.withOpacity(0.3),
                                        blurRadius: 10,
                                        spreadRadius: 1,
                                        offset: Offset(0, 1),
                                      )
                                    ]),
                                child: Center(
                                  child: Text(
                                    letters.toUpperCase(),
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontFamily: 'Guava Candy',
                                      color: palette.trueWhite,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
                Gap(30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// TODO: Test.



