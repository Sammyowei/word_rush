import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../src.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    this.showRightBtn = true,
    this.showTitle = true,
    this.titleImagePath = 'assets/images/btn/',
    required this.color,
    required this.title,
    required this.leftBtnPath,
    required this.rightBtnPath,
    this.leftBtnOnTap,
    this.rightBtnOnTap,
    this.forCoin = false,
  });

  final Palette color;

  final bool showRightBtn;
  final bool showTitle;
  final String titleImagePath;
  final String title;
  final String leftBtnPath;
  final String rightBtnPath;
  final VoidCallback? leftBtnOnTap;
  final VoidCallback? rightBtnOnTap;
  final bool forCoin;

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<PlayerProgress>();

    final _image = GameConstant.images;
    return Container(
      height: 60,
      decoration: const BoxDecoration(
          // color: color.darkPen,
          ),
      width: MediaQuery.sizeOf(context).width,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        InkWell(
          onTap: leftBtnOnTap,
          child: Image.asset(
            leftBtnPath,
            height: 40,
          ),
        ),
        showTitle
            ? Text(
                title,
                style: TextStyle(
                  fontFamily: 'Guava Candy',
                  fontSize: 30,
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
              )
            : Container(),
        showRightBtn
            ? InkWell(
                onTap: rightBtnOnTap,
                child: Image.asset(
                  rightBtnPath,
                  height: 40,
                ),
              )
            : Container(
                height: 30,
                padding: EdgeInsets.only(left: 5, right: 5),
                decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    color: color.btnColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      _image.coinsIcon,
                      height: 25,
                    ),
                    Gap(5),
                    Text(
                      '${progress.coinsAmount}',
                      style: TextStyle(
                        fontFamily: 'Guava Candy',
                        fontSize: 18,
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
                    )
                  ],
                ),
              ),
      ]),
    );
  }
}
