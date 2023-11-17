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
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                            image.settingBoard,
                          ),
                        ),
                      ),
                      child: GridView.builder(
                        itemCount: gameLevels.length,
                        clipBehavior: Clip.antiAlias,
                        padding: const EdgeInsets.all(20),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 30,
                          mainAxisSpacing: 30,
                        ),
                        itemBuilder: (context, index) {
                          final level = gameLevels[index];
                          final levelEnabled = (playerProgress
                                      .highestLevelReached >=
                                  level.level - 1 &&
                              playerProgress.coinsAmount >= level.coinValue);
                          return Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              shadows: [
                                BoxShadow(
                                  color: palette.backgroundSettings,
                                  blurRadius: 7,
                                  spreadRadius: 1,
                                  offset: const Offset(1, 1),
                                )
                              ],
                              color: palette.btnColor,
                              image: DecorationImage(
                                scale: 1,
                                matchTextDirection: true,
                                alignment: Alignment.center,
                                image: AssetImage(
                                  image.levelTable1,
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
