import 'package:flutter/material.dart';
import 'package:logging/logging.dart' hide Level;
import 'package:provider/provider.dart';

import '../src.dart';

class PlaaySessionScreen extends StatefulWidget {
  final GameLevel level;
  const PlaaySessionScreen({super.key, required this.level});

  @override
  State<PlaaySessionScreen> createState() => _PlaaySessionScreenState();
}

class _PlaaySessionScreenState extends State<PlaaySessionScreen> {
  static final _log = Logger('PlaySessionScreen');

  static const _celebrationDuration = Duration(milliseconds: 2000);

  static const _preCelebrationDuration = Duration(milliseconds: 500);

  final _image = GameConstant.images;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final palette = context.watch<Palette>();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GameTimer(),
        ),
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
              image: AssetImage(
                _image.backgroundImage,
              ),
            ),
          ),
        )),
      ),
    );
  }
}
