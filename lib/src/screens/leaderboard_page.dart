import 'package:flutter/material.dart';

class LeaderBoard extends StatelessWidget {
  const LeaderBoard({super.key, required this.ready, required this.child});

  final Future<bool> ready;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [_hideUntilReady(child: child, ready: ready)],
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

      print(snapshot.hasData);
      print(snapshot.data);
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
