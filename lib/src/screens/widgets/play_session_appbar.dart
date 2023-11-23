import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../src.dart';

Widget playSessionAppBar(
  BuildContext context,
  Size size,
  Palette palette,
  ImageConstants images,
) {
  final countDownModel = Provider.of<CountdownModel>(context);
  return SizedBox(
    height: 60,
    width: size.width,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          onTap: () => countDownModel.isPaused
              ? countDownModel.resumeTimer()
              : countDownModel.pauseTimer(),
          child: Image.asset(
            images.pauseBtn,
            height: 40,
          ),
        ),
        Container(
          width: size.width / 4,
          height: 45,
          // color: Colors.red,
          child: Center(
            child: Stack(
              children: [
                Positioned(
                  top: 5,
                  left: 25,
                  right: 2,
                  child: Align(
                    child: Consumer<CountdownModel>(
                      builder: (context, model, _) {
                        int minutes = (model.secondsRemaining / 60).truncate();
                        int seconds = model.secondsRemaining % 60;

                        return Container(
                          width: 75,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(60),
                              bottomRight: Radius.circular(60),
                            ),
                            image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(
                                images.settingBoard,
                              ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '$minutes:${seconds.toString().padLeft(2, '0')}',
                              style: TextStyle(
                                fontFamily: 'Guava Candy',
                                fontSize: 20,
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
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 5,
                  child: Align(
                    child: Image.asset(
                      images.clock,
                      height: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 30,
          padding: EdgeInsets.only(left: 5, right: 5),
          decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
              color: palette.btnColor),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                images.coinsIcon,
                height: 25,
              ),
              Gap(5),
              Consumer<PlayerProgress>(
                builder: (context, progress, child) {
                  return Text(
                    '${progress.coinsAmount}',
                    style: TextStyle(
                      fontFamily: 'Guava Candy',
                      fontSize: 18,
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
                  );
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
