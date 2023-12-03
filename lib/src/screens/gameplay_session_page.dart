// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';

// import 'package:logging/logging.dart' hide Level;
import 'package:provider/provider.dart';

import 'package:word_rush/src/logic/logic.dart';

import 'package:word_rush/src/screens/widgets/play_session_appbar.dart';

import '../src.dart';

final _log = Logger('gameplay_session_screen.dart');

class PlaaySessionScreen extends StatefulWidget {
  final GameLevel level;
  const PlaaySessionScreen({super.key, required this.level});

  @override
  State<PlaaySessionScreen> createState() => _PlaaySessionScreenState();
}

class _PlaaySessionScreenState extends State<PlaaySessionScreen> {
  final _image = GameConstant.images;

  String gameWord = '';

  String userWord = '';

  static const _celebrationDuration = Duration(milliseconds: 3000);

  static const _preCelebrationDuration = Duration(milliseconds: 500);
  List<String> letters = [];

  List<String> filteredWords = [];

  bool _duringCelebration = false;

  int coinAmount = 0;
  late DateTime _startOfPlay;
//TODO:  Game Functions

  void _submit(BuildContext context) {
    if (userWord.isEmpty) {
      final audioController = context.read<AudioController>();
      audioController.playSfx(SfxType.error);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          dismissDirection: DismissDirection.horizontal,
          backgroundColor: Colors.red,
          duration: Durations.long4,
          behavior: SnackBarBehavior.floating,
          content: Text(
            'Enter a word',
            style: TextStyle(
              fontFamily: 'Guava Candy',
              fontSize: 20,
            ),
          ),
        ),
      );
      return;
    } else {
      if (!(filteredWords.contains(userWord))) {
        final audioController = context.read<AudioController>();
        audioController.playSfx(SfxType.error);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            dismissDirection: DismissDirection.horizontal,
            backgroundColor: Colors.red,
            duration: Durations.long4,
            content: Text(
              'Wrong Word',
              style: TextStyle(
                fontFamily: 'Guava Candy',
                fontSize: 20,
              ),
            ),
          ),
        );
        return;
      } else {
        final audioController = context.read<AudioController>();

        final game = context.read<GameLogic>();

        if (game.foundWords.contains(userWord)) {
          audioController.playSfx(SfxType.error);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              dismissDirection: DismissDirection.horizontal,
              backgroundColor: Colors.red,
              duration: Durations.long4,
              content: Text(
                'Word Already exist',
                style: TextStyle(
                  fontFamily: 'Guava Candy',
                  fontSize: 20,
                ),
              ),
            ),
          );
          return;
        }

        audioController.playSfx(SfxType.summit);
        game.addToFoundWord(userWord);
        setState(() {
          userWord = '';
        });
        return;
      }
    }
  }

  int coinValue(BuildContext context) {
    int _coin = 0;
    final foundWords = context.watch<GameLogic>().foundWords;

    for (var word in foundWords) {
      if (word.length <= 3) {
        _coin += 300;
      } else {
        _coin += (word.length * 100);
      }
    }
    return _coin;
  }

  void _onPlayerWon(BuildContext context) async {
    final countDownModel = Provider.of<CountdownModel>(context);

    //  Stop the Timer
    countDownModel.pauseTimer();

    // Log the game Build.
    _log.info('Level ${widget.level.level} won');
    var wordsNeeded = widget.level.level <= 5 ? 5 : widget.level.level;
    final game = context.read<GameLogic>();
    if (game.foundWords.length == wordsNeeded) {
      final score = Score(
        widget.level.level,
        widget.level.difficulty,
        DateTime.now().difference(_startOfPlay),
      );

      final playerProgress = context.read<PlayerProgress>();
      playerProgress.setLevelReached(widget.level.level);

      final coinAmount = coinValue(context);

      print(coinValue);
      playerProgress.setCoinsCollected(coinAmount);

      // Let the player see the game just after winning for a bit.
      await Future<void>.delayed(_preCelebrationDuration);
      if (!mounted) return;

      setState(() {
        _duringCelebration = true;
      });

      final audioController = context.read<AudioController>();
      audioController.playSfx(SfxType.success);

      final gamesServicesController = context.read<GamesServicesController?>();
      if (gamesServicesController != null) {
        // Award achievement.
        if (widget.level.awardsAchievement) {
          await gamesServicesController.awardAchievement(
            android: widget.level.achievementIdAndroid!,
            iOS: widget.level.achievementIdIOS!,
          );
        }

        // Send score to leaderboard.
        await gamesServicesController.submitLeaderboardScore(score);
      }

      /// Give the player some time to see the celebration animation.
      await Future<void>.delayed(_celebrationDuration);
      if (!mounted) return;

      GoRouter.of(context).pop();
      game.resetFoundWords();
      countDownModel.dispose();
    } else {
      print('Level not won');
      _onGameOver(context);
      return;
    }
  }

  void _onGameOver(BuildContext context) {
    final countDownModel = Provider.of<CountdownModel>(context);
    final seconds = countDownModel.secondsRemaining;

    if (seconds == 0) {
      print('Game Over');
    } else {
      print(seconds);
    }
  }

  // TODO: Spell Word
  void _spellWord(int index) {
    userWord = userWord + letters[index];
    setState(() {
      userWord;
    });
  }

  void _onRemoveLast() {
    final userLetters = userWord.split('');
    userLetters.removeLast();
    setState(() {
      userWord = userLetters.join();
    });
  }

  @override
  void initState() {
    super.initState();
    Provider.of<CountdownModel>(context, listen: false).startTimer(5);
    gameWord = Provider.of<GameLogic>(context, listen: false).gameWord();
    _startOfPlay = DateTime.now();
    letters = gameWord.split('');

    letters.shuffle();

    filteredWords = Provider.of<GameLogic>(context, listen: false)
        .gamePlayWords(letters, 5);
    print(filteredWords);
    print(letters);
    print(coinAmount);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Provider.of<CountdownModel>(context).dispose();
  }

  bool isClicked = false;
  @override
  Widget build(BuildContext context) {
    bool _userHasTyped = userWord.isEmpty;
    _onPlayerWon(context);
    _onGameOver(context);
    coinAmount = Provider.of<PlayerProgress>(context, listen: true).coinsAmount;
    final game = context.watch<GameLogic>();
    final playerProgress = context.watch<PlayerProgress>();

    final size = MediaQuery.sizeOf(context);
    final palette = context.watch<Palette>();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LevelState(
            goal: widget.level.difficulty,
            onWin: () => _onPlayerWon(context),
          ),
        ),
      ],
      child: IgnorePointer(
        ignoring: _duringCelebration,
        child: Scaffold(
          body: Stack(
            children: [
              SafeArea(
                child: SingleChildScrollView(
                  child: Container(
                    height: size.height,
                    width: size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                          _image.gamePlayBackground,
                        ),
                      ),
                    ),
                    child: Column(
                      children: [
                        playSessionAppBar(context, size, palette, _image),
                        // TODO:  Word Found session;
                        const Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Found Words',
                              style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'Guava Candy',
                                color: palette.trueWhite,
                              ),
                            ),
                          ],
                        ),
                        Gap(10),
                        Consumer<GameLogic>(builder: (context, data, child) {
                          return Container(
                            // color: Colors.blue,
                            height: 470,
                            child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 4,
                                ),
                                itemCount: data.foundWords.length,
                                itemBuilder: (_, index) {
                                  return Container(
                                    height: 20,
                                    width: 20,
                                    decoration: ShapeDecoration(
                                      color: palette.trueWhite.withOpacity(0.3),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    padding:
                                        EdgeInsets.only(left: 20, right: 20),
                                    child: Row(
                                      children: [
                                        Text(
                                          '${index + 1}. ${data.foundWords[index]}',
                                          style: TextStyle(
                                              color: palette.inkFullOpacity,
                                              fontFamily: 'Guava Candy',
                                              fontSize: 25),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          );
                        }),

                        // TODO: WOrd Controller

                        Expanded(
                          child: Container(
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                ),
                                side: BorderSide(
                                    color: palette.btnColor,
                                    width: 10,
                                    strokeAlign: -1),
                              ),
                              shadows: [
                                BoxShadow(
                                  color: Colors.black87.withOpacity(0.3),
                                  spreadRadius: 5,
                                  blurRadius: 5,
                                ),
                              ],
                              image: DecorationImage(
                                fit: BoxFit.fill,
                                image: AssetImage(_image.gamePlayBackground),
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: 135,
                                  width: MediaQuery.sizeOf(context).width,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  padding: EdgeInsets.only(left: 10, right: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          height: 80,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'remove',
                                                style: TextStyle(
                                                  fontFamily: 'Guava Candy',
                                                  color: palette.trueWhite
                                                      .withOpacity(0.8),
                                                  fontSize: 20,
                                                ),
                                              ),
                                              IconButton(
                                                iconSize: 35,
                                                onPressed: () =>
                                                    _onRemoveLast(),
                                                icon: Icon(
                                                  Icons.remove,
                                                  color: Colors.red
                                                      .withOpacity(0.9),
                                                ),
                                              )
                                            ],
                                          )),
                                      Container(
                                        height: 80,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Your Word:',
                                              style: TextStyle(
                                                fontFamily: 'Guava Candy',
                                                color: palette.trueWhite
                                                    .withOpacity(0.8),
                                                fontSize: 20,
                                              ),
                                            ),
                                            Gap(15),
                                            Text(
                                              userWord,
                                              style: TextStyle(
                                                fontFamily: 'Guava Candy',
                                                color: palette.trueWhite,
                                                fontSize: 25,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        height: 80,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Summit',
                                              style: TextStyle(
                                                fontFamily: 'Guava Candy',
                                                color: palette.trueWhite
                                                    .withOpacity(0.8),
                                                fontSize: 20,
                                              ),
                                            ),
                                            IconButton(
                                              iconSize: 35,
                                              onPressed: () => _submit(context),
                                              icon: Icon(
                                                Icons.send_rounded,
                                                color: Colors.green
                                                    .withOpacity(0.9),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 100,
                                  // color: Colors.amber,
                                  padding: EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: List.generate(
                                      letters.length,
                                      (index) => GestureDetector(
                                        onTap: () => _spellWord(index),
                                        child: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.fill,
                                              image: AssetImage(
                                                _image.settingBoard,
                                              ),
                                            ),
                                            color: palette.btnColor,
                                          ),
                                          child: Center(
                                            child: Text(
                                              letters[index],
                                              style: TextStyle(
                                                fontFamily: 'Guava Candy',
                                                color: palette.trueWhite,
                                                fontSize: 24,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox.expand(
                child: Visibility(
                  visible: _duringCelebration,
                  child: IgnorePointer(
                    child: Confetti(
                      isStopped: !_duringCelebration,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// TODO: Test.
