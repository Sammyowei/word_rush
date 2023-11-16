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

                // Game Body
                Container(),

                // TODO: Build Footer
                Container(
                  height: 60,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        child: Image.asset(
                          image.prizeBtn,
                        ),
                      ),
                      InkWell(
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
