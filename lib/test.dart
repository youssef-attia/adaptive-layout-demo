import 'package:flutter/material.dart';
import 'dart:math';


void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AnimatedWidget bottomToTop(Widget child, AnimationController animation) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0, 1),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    }

    AnimatedWidget topToBottom(Widget child, AnimationController animation) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(0, 1),
        ).animate(animation),
        child: child,
      );
    }

    AnimatedWidget leftOutIn(Widget child, AnimationController animation) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    }

    AnimatedWidget leftInOut(Widget child, AnimationController animation) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: Offset.zero,
          end: const Offset(-1, 0),
        ).animate(animation),
        child: child,
      );
    }

    AnimatedWidget rightOutIn(Widget child, AnimationController animation) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    }

    Widget on(_){return Container(width: 100, height: 100, color: Colors.primaries[Random().nextInt(Colors.primaries.length)]);}
    Widget on1(_){return Container(width: 100, height: 600, color: Colors.primaries[Random().nextInt(Colors.primaries.length)]);}
    Widget off(_){return const SizedBox(width: 0, height: 0);}
    SizedBox layout(double width) {
      return SizedBox(
        width: width,
        child: MaterialApp(
              home: AdaptiveLayout(
                primaryNavigation: SlotLayout(
                  config: <int, SlotLayoutConfig?>{
                    900: SlotLayoutConfig(inAnimation: leftOutIn, outAnimation: leftInOut, key: const Key('800'), builder: on1),
                  },
                ),
                secondaryNavigation: SlotLayout(
                  config: <int, SlotLayoutConfig>{
                    800: SlotLayoutConfig(key: const Key('snav1'), builder: on),
                  },
                ),
                topNavigation: SlotLayout(
                  config: <int, SlotLayoutConfig>{
                    800: SlotLayoutConfig(key: const Key('tnav1'), builder: on),
                  },
                ),
                bottomNavigation: SlotLayout(
                  config: <int, SlotLayoutConfig>{
                    800: SlotLayoutConfig(key: const Key('bnav1'), builder: on),
                  },
                ),
                body: SlotLayout(
                  config: <int, SlotLayoutConfig>{
                    0: SlotLayoutConfig(key: const Key('b'), builder: (_) => Container(color: Colors.red,)),
                    800: SlotLayoutConfig(key: const Key('b1'), builder: (_) => Container(color: Colors.red,)),
                  },
                ),
                secondaryBody: SlotLayout(
                  config: <int, SlotLayoutConfig>{
                    800: SlotLayoutConfig(key: const Key('sb1'), builder: (_) => Container(color: Colors.blue,)),
                  },
                ),
              ),
            ),
      );
    }
    return layout(1500);
  }
}