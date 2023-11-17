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
              )
            ],
          ),
        ),
      ),
    );
  }
}
