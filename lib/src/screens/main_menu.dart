import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../src.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  final images = GameConstant.images;
  @override
  Widget build(BuildContext context) {
    final controller = context.watch<SettingsController>();
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   title: Text(widget.title),
      // ),
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
        ),
      ),
      // floatingActionButton: Row(
      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //   children: [
      //     FloatingActionButton(
      //       onPressed: () async {
      //         controller.toggleMuted();
      //       },
      //       tooltip: 'Increment',
      //       child: const Icon(Icons.add),
      //     ),
      //     FloatingActionButton(
      //       onPressed: () async {
      //         await AdManager.showRewardedAds();
      //       },
      //       tooltip: 'Increment',
      //       child: const Icon(Icons.remove),
      //     ),
      //   ],
      // ),
    );
  }
}
