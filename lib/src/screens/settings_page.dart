import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../src.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final image = GameConstant.images;
  @override
  Widget build(BuildContext context) {
    final palette = context.watch<Palette>();
    final audioController = context.watch<AudioController>();
    final settingsController = context.watch<SettingsController>();
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
              children: [
                CustomAppBar(
                  showRightBtn: false,
                  showTitle: false,
                  color: palette,
                  leftBtnPath: image.prevButton,
                  rightBtnPath: image.faqBtn,
                  leftBtnOnTap: () {
                    audioController.playSfx(SfxType.btnClicked);
                    context.pop();
                  },
                  title: 'Settings',
                ),
                // const Gap(60),
                Image.asset(image.settingHeader),
                Container(
                  padding: const EdgeInsets.only(
                    left: 25,
                    right: 25,
                    top: 30,
                    bottom: 30,
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 60,
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Sounds',
                              style: TextStyle(
                                fontFamily: 'Guava Candy',
                                fontSize: 45,
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
                            ValueListenableBuilder(
                              valueListenable: settingsController.soundsOn,
                              builder: (context, value, child) {
                                return InkWell(
                                  onTap: () {
                                    settingsController.toggleSoundsOn();
                                    audioController.playSfx(SfxType.btnClicked);
                                  },
                                  child: value
                                      ? Image.asset(image.soundBtn)
                                      : Image.asset(image.soundOffBtn),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      const Gap(20),
                      Container(
                        height: 60,
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Music',
                              style: TextStyle(
                                fontFamily: 'Guava Candy',
                                fontSize: 45,
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
                            ValueListenableBuilder(
                              valueListenable: settingsController.musicOn,
                              builder: (context, value, child) {
                                return InkWell(
                                  onTap: () {
                                    settingsController.toggleMusicOn();

                                    audioController.playSfx(SfxType.btnClicked);
                                  },
                                  child: value
                                      ? Image.asset(image.musicOnBtn)
                                      : Image.asset(image.muteBtn),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                      const Gap(20),
                      Container(
                        height: 60,
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'info',
                              style: TextStyle(
                                fontFamily: 'Guava Candy',
                                fontSize: 45,
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
                            // ValueListenableBuilder(
                            //   valueListenable: settingsController.soundsOn,
                            //   builder: (context, value, child) {
                            //     return InkWell(
                            //       onTap: () {
                            //         settingsController.toggleSoundsOn();
                            //         if (value == true) {
                            //           audioController
                            //               .playSfx(SfxType.btnClicked);
                            //         } else {
                            //           return;
                            //         }
                            //       },
                            //       child: value
                            //           ? Image.asset(image.soundBtn)
                            //           : Image.asset(image.soundOffBtn),
                            //     );
                            //   },
                            // )

                            InkWell(
                              onTap: () {},
                              child: Image.asset(image.aboutBtn),
                            )
                          ],
                        ),
                      ),
                      const Gap(20),
                      Container(
                        height: 60,
                        width: MediaQuery.sizeOf(context).width * 0.8,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Terms',
                              style: TextStyle(
                                fontFamily: 'Guava Candy',
                                fontSize: 45,
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
                            // ValueListenableBuilder(
                            //   valueListenable: settingsController.soundsOn,
                            //   builder: (context, value, child) {
                            //     return InkWell(
                            //       onTap: () {
                            //         settingsController.toggleSoundsOn();
                            //         if (value == true) {
                            //           audioController
                            //               .playSfx(SfxType.btnClicked);
                            //         } else {
                            //           return;
                            //         }
                            //       },
                            //       child: value
                            //           ? Image.asset(image.soundBtn)
                            //           : Image.asset(image.soundOffBtn),
                            //     );
                            //   },
                            // )
                            InkWell(
                              onTap: () {},
                              child: Image.asset(image.faqBtn),
                            )
                          ],
                        ),
                      ),
                    ],
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
