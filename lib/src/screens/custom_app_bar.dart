import 'package:flutter/material.dart';

import '../src.dart';

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

  static final _image = GameConstant.images;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          // color: color.darkPen,
          ),
      width: MediaQuery.sizeOf(context).width,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        forCoin
            ? Container()
            : InkWell(
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
            : Container(),
      ]),
    );
  }
}
