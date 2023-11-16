import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:word_rush/src/src.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({super.key, this.header, this.desc, this.height});
  static final ImageConstants _image = GameConstant.images;
  final String? header;
  final String? desc;
  final double? height;
  @override
  Widget build(BuildContext context) {
    final color = context.watch<Palette>();
    final audioController = context.watch<AudioController>();
    return Container(
      padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 30),
      height: height ?? 280,
      width: MediaQuery.sizeOf(context).width * 0.9,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(_image.settingBoard),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: Column(
              children: [
                Text(
                  header ?? 'Coming Soon',
                  style: TextStyle(
                    fontFamily: 'Guava Candy',
                    fontSize: 40,
                    color: color.trueWhite,
                    shadows: [
                      Shadow(
                        color: color.btnColor,
                        offset: const Offset(0, 3),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                ),
                const Gap(10),
                Text(
                  desc ?? 'Coming Soon',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Guava Candy',
                    fontSize: 20,
                    color: color.trueWhite.withOpacity(0.88),
                    shadows: [
                      Shadow(
                        color: color.btnColor,
                        offset: const Offset(0, 3),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const Gap(20),
          InkWell(
            onTap: () {
              audioController.playSfx(SfxType.btnClicked);
              context.pop();
            },
            child: Container(
              height: 50,
              width: MediaQuery.sizeOf(context).width * 0.35,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                      color: color.trueWhite,
                      width: 5,
                      style: BorderStyle.solid,
                      strokeAlign: -2),
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                ),
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(_image.btn),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Close',
                    style: TextStyle(
                      fontFamily: 'Guava Candy',
                      fontSize: 25,
                      color: color.trueWhite.withOpacity(0.88),
                      shadows: [
                        Shadow(
                          color: color.btnColor,
                          offset: const Offset(0, 3),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
