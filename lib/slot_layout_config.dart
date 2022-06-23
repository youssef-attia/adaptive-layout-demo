import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SlotLayoutConfig extends StatefulWidget {
  SlotLayoutConfig({
    required this.child,
    this.controller,
    this.animation,
    super.key,
  });
  final Widget child;
  final Function? animation;
  AnimationController? controller;

  @override
  State<SlotLayoutConfig> createState() => SlotLayoutConfigState();
}

class SlotLayoutConfigState extends State<SlotLayoutConfig> {
  @override
  Widget build(BuildContext context) {
    return (widget.animation != null && widget.controller != null)
        ? widget.animation!(widget.controller, widget.child)
        : widget.child;
  }
}
