import 'package:flutter/material.dart';
import 'slot_layout.dart';

class AdaptiveLayout extends StatefulWidget {
  const AdaptiveLayout({
    this.leftNavigation,
    this.rightNavigation,
    this.topNavigation,
    this.bottomNavigation,
    this.body,
    this.bodyLeft,
    this.bodyRatio,
    super.key,
  });

  final SlotLayout? leftNavigation;
  final SlotLayout? rightNavigation;
  final SlotLayout? topNavigation;
  final SlotLayout? bottomNavigation;
  final SlotLayout? body;
  final SlotLayout? bodyLeft;
  final double? bodyRatio;

  @override
  State<AdaptiveLayout> createState() => _AdaptiveLayoutState();
}

class _AdaptiveLayoutState extends State<AdaptiveLayout> with TickerProviderStateMixin {
  late AnimationController _controller;
  ValueNotifier bodyNotifier = ValueNotifier(false);
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();
    bodyNotifier.value = widget.bodyLeft?.isActive;
    bodyNotifier.addListener(() {
      if (bodyNotifier.value == true) {
        _controller.reset();
        _controller.forward();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, SlotLayout?> slots = {
      'leftNavigation': widget.leftNavigation,
      'rightNavigation': widget.rightNavigation,
      'topNavigation': widget.topNavigation,
      'bottomNavigation': widget.bottomNavigation,
      'body': widget.body,
      'bodyLeft': widget.bodyLeft,
    };

    slots.forEach((key, value) {
      slots.update(
        key,
        (val) => val,
        ifAbsent: () => value,
      );
    });

    List<Widget> entries = slots.entries
        .map((entry) {
          if (entry.value != null) {
            return LayoutId(id: entry.key, child: entry.value ?? Container());
          }
        })
        .toList()
        .whereType<Widget>()
        .toList();
    bodyNotifier.value = widget.bodyLeft!=null?(widget.bodyLeft!.config.entries.first.key < MediaQuery.of(context).size.width):null;
    return CustomMultiChildLayout(
      delegate: _AdaptiveLayoutDelegate(
        notifier: bodyNotifier,
        controller: _controller,
        slots: slots,
        bodyRatio: widget.bodyRatio,
      ),
      children: entries,
    );
  }
}

class _AdaptiveLayoutDelegate extends MultiChildLayoutDelegate {
  _AdaptiveLayoutDelegate({
    required this.slots,
    required this.bodyRatio,
    required this.controller,
    required this.notifier,
  }) : super(relayout: controller);

  final Map<String, SlotLayout?> slots;
  final double? bodyRatio;
  final AnimationController controller;
  final ValueNotifier notifier;

  @override
  void performLayout(Size size) {
    Offset bodyOffsetLT = Offset.zero;
    Offset bodyOffsetRB = Offset.zero;

    if (hasChild('leftNavigation')) {
      Size currentSize = layoutChild('leftNavigation', BoxConstraints.loose(size));
      positionChild('leftNavigation', Offset.zero);
      bodyOffsetLT += Offset(currentSize.width, 0);
    }
    if (hasChild('rightNavigation')) {
      Size currentSize = layoutChild('rightNavigation', BoxConstraints.loose(size));
      positionChild('rightNavigation', Offset(size.width - currentSize.width, 0));
      bodyOffsetRB += Offset(currentSize.width, 0);
    }
    if (hasChild('topNavigation')) {
      Size currentSize = layoutChild('topNavigation', BoxConstraints.loose(size));
      positionChild('topNavigation', Offset.zero);
      bodyOffsetLT += Offset(0, currentSize.height);
    }
    if (hasChild('bottomNavigation')) {
      Size currentSize = layoutChild('bottomNavigation', BoxConstraints.loose(size));
      positionChild('bottomNavigation', Offset(0, size.height - currentSize.height));
      bodyOffsetRB += Offset(0, currentSize.height);
    }

    if (hasChild('body') && hasChild('bodyLeft')) {
      Size currentSize;
      if (!slots['bodyLeft']!.isActive) {
        currentSize = layoutChild(
            'body',
            BoxConstraints.tight(
                Size(size.width - bodyOffsetRB.dx - bodyOffsetLT.dx, size.height - bodyOffsetRB.dy - bodyOffsetLT.dy)));
        layoutChild('bodyLeft', BoxConstraints.loose(size));
      } else {
        if (bodyRatio == null) {
          currentSize = layoutChild(
              'body',
              BoxConstraints.tight(Size(
                  Tween(
                          begin: size.width - bodyOffsetRB.dx - bodyOffsetLT.dx,
                          end: size.width / 2 - bodyOffsetRB.dx - bodyOffsetLT.dx)
                      .animate(CurvedAnimation(parent: controller, curve: Curves.easeInOutCubic))
                      .value,
                  size.height - bodyOffsetRB.dy - bodyOffsetLT.dy)));
          layoutChild(
              'bodyLeft', BoxConstraints.tight(Size(size.width / 2, size.height - bodyOffsetRB.dy - bodyOffsetLT.dy)));
        } else {
          currentSize = layoutChild(
              'body',
              BoxConstraints.tight(Size(
                  Tween(
                          begin: size.width - bodyOffsetRB.dx - bodyOffsetLT.dx,
                          end: (size.width - bodyOffsetRB.dx - bodyOffsetLT.dx) * bodyRatio!)
                      .animate(CurvedAnimation(parent: controller, curve: Curves.easeInOutCubic))
                      .value,
                  size.height - bodyOffsetRB.dy - bodyOffsetLT.dy)));
          layoutChild(
            'bodyLeft',
            BoxConstraints.tight(Size((size.width - bodyOffsetRB.dx - bodyOffsetLT.dx) * (1 - bodyRatio!), size.height - bodyOffsetRB.dy - bodyOffsetLT.dy)),
          );
        }
      }
      positionChild('body', bodyOffsetLT);
      positionChild('bodyLeft', Offset(bodyOffsetLT.dx + currentSize.width, bodyOffsetLT.dy));
    } else if (hasChild('body')) {
      layoutChild(
        'body',
        BoxConstraints.tight(
            Size(size.width - bodyOffsetRB.dx - bodyOffsetLT.dx, size.height - bodyOffsetRB.dy - bodyOffsetLT.dy)),
      );
      positionChild('body', bodyOffsetLT);
    } else if (hasChild('bodyLeft')) {
      layoutChild(
        'bodyLeft',
        BoxConstraints.tight(
            Size(size.width - bodyOffsetRB.dx - bodyOffsetLT.dx, size.height - bodyOffsetRB.dy - bodyOffsetLT.dy)),
      );

    }
  }

  @override
  bool shouldRelayout(_AdaptiveLayoutDelegate oldDelegate) {
    return oldDelegate.slots != slots;
  }
}
