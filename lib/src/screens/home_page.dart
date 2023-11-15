import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:logging/logging.dart';
import 'package:provider/provider.dart';
import '../src.dart';

class HomePage extends StatelessWidget {
  const HomePage(this.info, {super.key});
  final String info;
  @override
  Widget build(BuildContext context) {
    final _logger = Logger(info);
    _logger.info(info);
    final images = GameConstant.images;
    final color = context.watch<Palette>();
    final audioController = context.watch<AudioController>();
    // final controller = context.watch<SettingsController>();
    const gap = Gap(10);

    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                images.backgroundImage,
              ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  child: Column(
                    children: [
                      Text(
                        'Word Rush',
                        style: TextStyle(
                          fontFamily: 'Guava Candy',
                          fontSize: 65,
                          color: color.trueWhite,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: color.btnColor,
                              offset: const Offset(0, 3),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                      ),
                      gap,
                      gap,
                      gap,
                      gap,
                      InkWell(
                        onTap: () {
                          audioController.playSfx(SfxType.btnClicked);
                          // context.pushReplacementNamed();
                        },
                        child: Container(
                          height: 60,
                          width: MediaQuery.sizeOf(context).width * 0.5,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: color.btnColor.withAlpha(235),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                images.playBtn,
                                height: 45,
                              ),
                              gap,
                              Text(
                                'Play',
                                style: TextStyle(
                                  fontFamily: 'Guava Candy',
                                  fontSize: 40,
                                  color: color.trueWhite,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: color.btnColor,
                                      offset: const Offset(0, 1),
                                      blurRadius: 4,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Text(
                    'Powered by Bumble Software, LLC.',
                    style: TextStyle(
                      fontFamily: 'Guava Candy',
                      fontSize: 18,
                      color: color.trueWhite.withOpacity(0.4),
                    ),
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
