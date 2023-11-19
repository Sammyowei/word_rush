import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../src.dart';

class LevelSelection extends StatelessWidget {
  const LevelSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final playerProgress = context.watch<PlayerProgress>();
    final audioController = context.watch<AudioController>();

    final image = GameConstant.images;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          padding: EdgeInsets.symmetric(
            horizontal: 15,
          ),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(image.backgroundImage),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomAppBar(
                color: palette,
                title: 'Level',
                forCoin: true,
                showTitle: false,
                showRightBtn: false,
                leftBtnPath: image.prevButton,
                leftBtnOnTap: () {
                  audioController.playSfx(SfxType.btnClicked);
                  context.pop();
                },
                rightBtnPath: image.prevButton,
              ),

              // TODO: LevelSelection body

              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(image.levelHeader),
                    Container(
                      height: 400,
                      width: MediaQuery.sizeOf(context).width,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white.withOpacity(0.4),
                        // image: DecorationImage(
                        //   fit: BoxFit.fill,
                        //   image: AssetImage(
                        //     image.settingBoard,
                        //   ),
                        // ),
                      ),
                      child: GridView.builder(
                        itemCount: gameLevels.length,
                        addSemanticIndexes: true,
                        // scrollDirection: Axis.horizontal,
                        clipBehavior: Clip.antiAlias,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 50,
                          mainAxisSpacing: 40,
                        ),
                        itemBuilder: (context, index) {
                          // int newIndex = ( % 3) * 3 + (index ~/ 3);
                          final level = gameLevels[index];
                          final levelEnabled = (playerProgress
                                      .highestLevelReached >=
                                  level.level - 1 &&
                              playerProgress.coinsAmount >= level.coinValue);

                          return InkWell(
                            onTap: () {
                              if (levelEnabled) {
                                audioController.playSfx(SfxType.btnClicked);
                                print(
                                    'Game Level ${level.level} at index $index');
                                context.pushNamed(RouteNames.gameSession,
                                    pathParameters: {
                                      'level': "${level.level}"
                                    });

                                return;
                              }
                              audioController.playSfx(SfxType.btnClicked);
                              context.pushNamed(RouteNames.levelLocked, extra: {
                                'header': 'Locked',
                                'desc':
                                    'Level locked you need to have a minimum of ${level.coinValue} points to unlock this level'
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                    image.table,
                                  ),
                                ),
                              ),
                              child: Center(
                                child: Image.asset(
                                  levelEnabled
                                      ? levelNumber(index)
                                      : image.levelLock,
                                  color: levelEnabled ? null : palette.btnColor,
                                  height: levelEnabled ? null : 40,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // TODO: Footer Do not modify
              Container(),
              Container(),
              Container(),
            ],
          ),
        ),
      ),
    );
  }
}

String levelNumber(int index) {
  final image = GameConstant.images;
  switch (index) {
    case 0:
      return image.one;
    case 1:
      return image.two;
    case 2:
      return image.three;

    case 3:
      return image.four;

    case 4:
      return image.five;
    case 5:
      return image.six;
    case 6:
      return image.seven;
    case 7:
      return image.eight;
    case 8:
      return image.nine;
    default:
      return image.one;
  }
}
