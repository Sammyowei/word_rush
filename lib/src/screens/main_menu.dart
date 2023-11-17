import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../src.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  final image = GameConstant.images;
  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final audioController = context.watch<AudioController>();
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                image.backgroundImage,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //  TODO:  Custom AppBar For Main Menu
                CustomAppBar(
                  color: palette,
                  showRightBtn: false,
                  showTitle: false,
                  leftBtnPath: image.settingsBtn,
                  rightBtnPath: image.settingsBtn,
                  leftBtnOnTap: () {
                    audioController.playSfx(SfxType.btnClicked);
                    context.goNamed(RouteNames.settings);
                  },
                  title: 'Main Menu',
                ),

                // TODO: Game Body
                Container(
                  height: 400,
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 30,
                    top: 30,
                    bottom: 60,
                  ),
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        image.settingBoard,
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Main Menu',
                        style: TextStyle(
                          fontFamily: 'Guava Candy',
                          fontSize: 50,
                          color: palette.trueWhite,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: palette.btnColor,
                              offset: const Offset(0, 3),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        child: Column(
                          children: [
                            Container(
                              height: 50,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Play',
                                    style: TextStyle(
                                      fontFamily: 'Guava Candy',
                                      fontSize: 40,
                                      color: palette.trueWhite,
                                      shadows: [
                                        Shadow(
                                          color: palette.btnColor,
                                          offset: const Offset(0, 3),
                                          blurRadius: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      audioController
                                          .playSfx(SfxType.btnClicked);
                                      context.goNamed(RouteNames.play);
                                    },
                                    child: Image.asset(
                                      image.playBtn,
                                      height: 50,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            const Gap(20),
                            Container(
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Achievements',
                                    style: TextStyle(
                                      fontFamily: 'Guava Candy',
                                      fontSize: 40,
                                      color: palette.trueWhite,
                                      // fontWeight: FontWeight.bold,
                                      shadows: [
                                        Shadow(
                                          color: palette.btnColor,
                                          offset: const Offset(0, 3),
                                          blurRadius: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      audioController
                                          .playSfx(SfxType.btnClicked);
                                      context.pushNamed(RouteNames.achievements,
                                          extra: {
                                            'header': 'Achievements',
                                            'desc':
                                                'There is no current achievement at the moment, please check back later.'
                                          });
                                    },
                                    child: Image.asset(
                                      image.prizeBtn,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Gap(20),
                            Container(
                              height: 50,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Leaderboard',
                                    style: TextStyle(
                                      fontFamily: 'Guava Candy',
                                      fontSize: 40,
                                      color: palette.trueWhite,
                                      shadows: [
                                        Shadow(
                                          color: palette.btnColor,
                                          offset: const Offset(0, 3),
                                          blurRadius: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      audioController
                                          .playSfx(SfxType.btnClicked);
                                      context.pushNamed(RouteNames.leaderBoard,
                                          extra: {
                                            'header': 'Leaderboard',
                                            'desc':
                                                'There is no current leaderboard at the moment, please check back later.'
                                          });
                                    },
                                    child: Image.asset(
                                      image.leaderBtn,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Container(),
                Container(),
                // TODO: Build Footer
              ],
            ),
          ),
        ),
      ),
    );
  }
}
