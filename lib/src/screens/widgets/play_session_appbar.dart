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
  final palette = context.watch<Palette>();
  final playerProgress = context.watch<PlayerProgress>();
  return Container(
    decoration: ShapeDecoration(
      image: DecorationImage(
          image: AssetImage(images.gamePlayBackground), fit: BoxFit.fill),
      shadows: [
        BoxShadow(
            color: Colors.black87.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5),
      ],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(15),
          bottomRight: Radius.circular(15),
        ),
      ),
      color: palette.btnColor.withOpacity(0.6),
    ),
    height: 60,
    width: size.width,
    child: Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
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
                          int minutes =
                              (model.secondsRemaining / 60).truncate();
                          int seconds = model.secondsRemaining % 60;

                          return Container(
                            width: 75,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(60),
                                bottomRight: Radius.circular(60),
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
                    top: 3,
                    left: 10,
                    child: Align(
                      child: Image.asset(
                        images.clock,
                        height: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Container(
          //   height: 30,
          //   padding: EdgeInsets.only(left: 5, right: 5),
          //   decoration: ShapeDecoration(
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(50)),
          //       color: palette.btnColor),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.end,
          //     children: [
          //       Image.asset(
          //         images.coinsIcon,
          //         height: 25,
          //       ),
          //       // Gap(5),
          //       // Consumer<PlayerProgress>(builder: (_, progress, child) {
          //       //   return Text(
          //       //     '${progress.coinsAmount}',
          //       //     style: TextStyle(
          //       //       fontFamily: 'Guava Candy',
          //       //       fontSize: 18,
          //       //       color: palette.trueWhite,
          //       //       fontWeight: FontWeight.bold,
          //       //       shadows: [
          //       //         Shadow(
          //       //           color: palette.btnColor,
          //       //           offset: const Offset(0, 3),
          //       //           blurRadius: 10,
          //       //         ),
          //       //       ],
          //       //     ),
          //       //   );
          //       // })
          //     ],
          //   ),
          // ),
        ],
      ),
    ),
  );
}
