import 'package:flutter/material.dart';
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
                CustomAppBar(
                  color: palette,
                  leftBtnPath: image.aboutBtn,
                  rightBtnPath: image.settingsBtn,
                  rightBtnOnTap: () {
                    audioController.playSfx(SfxType.btnClicked);
                    context.goNamed(RouteNames.settings);
                  },
                  title: 'Main Menu',
                ),
                Container(),
                Container(
                  height: 100,
                  color: palette.backgroundMain,
                  child: Row(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _hideUntilReady({required Widget child, required Future<bool> ready}) {
  return FutureBuilder<bool>(
    future: ready,
    builder: (context, snapshot) {
      // Use Visibility here so that we have the space for the buttons
      // ready.
      return Visibility(
        visible: snapshot.data ?? false,
        maintainState: true,
        maintainSize: true,
        maintainAnimation: true,
        child: child,
      );
    },
  );
}
