import 'package:flutter/material.dart';

/// [AdaptiveScaffold] is an abstraction that passes properties to
/// [AdaptiveLayout] and reduces repetition and a burden on the developer.
class AdaptiveScaffold extends StatefulWidget {
  /// Returns an [AdaptiveScaffold] by passing information down to an
  /// [AdaptiveLayout].
  const AdaptiveScaffold({
    this.destinations,
    this.selectedIndex = 0,
    this.smallBody,
    this.body,
    this.largeBody,
    this.smallSecondaryBody,
    this.secondaryBody,
    this.largeSecondaryBody,
    this.bodyRatio,
    this.breakpoints = const <int>[0, 480, 1024],
    this.displayAnimations = true,
    this.bodyAnimated = true,
    this.horizontalBody = true,
    super.key,
  });

  /// The destinations to be used in navigation items. These are converted to
  /// [NavigationRailDestination]s and [BottomNavigationBarItem]s and inserted
  /// into the appropriate places. If passing destinations, you must also pass a
  /// selected index to be used by the [NavigationRail].
  final List<NavigationDestination>? destinations;

  /// The index to be used by the [NavigationRail] if applicable.
  final int? selectedIndex;

  /// Widget to be displayed in the body slot at the smallest breakpoint.
  ///
  /// If nothing is entered for this property, then the default [body] is
  /// displayed in the slot. If null is entered for this slot, the slot stays
  /// empty.
  final WidgetBuilder? smallBody;

  /// Widget to be displayed in the body slot at the middle breakpoint.
  ///
  /// The default displayed body.
  final WidgetBuilder? body;

  /// Widget to be displayed in the body slot at the largest breakpoint.
  ///
  /// If nothing is entered for this property, then the default [body] is
  /// displayed in the slot. If null is entered for this slot, the slot stays
  /// empty.
  final WidgetBuilder? largeBody;

  /// Widget to be displayed in the secondaryBody slot at the smallest
  /// breakpoint.
  ///
  /// If nothing is entered for this property, then the default [secondaryBody]
  /// is displayed in the slot. If null is entered for this slot, the slot stays
  /// empty.
  final WidgetBuilder? smallSecondaryBody;

  /// Widget to be displayed in the secondaryBody slot at the middle breakpoint.
  ///
  /// The default displayed secondaryBody.
  final WidgetBuilder? secondaryBody;

  /// Widget to be displayed in the seconaryBody slot at the smallest
  /// breakpoint.
  ///
  /// If nothing is entered for this property, then the default [secondaryBody]
  /// is displayed in the slot. If null is entered for this slot, the slot stays
  /// empty.
  final WidgetBuilder? largeSecondaryBody;

  /// Defines the fractional ratio of body to the secondaryBody.
  ///
  /// For example 1 / 3 would mean body takes up 1/3 of the available space and
  /// secondaryBody takes up the rest.
  ///
  /// If this value is null, the ratio is defined so that the split axis is in
  /// the center of the screen.
  final double? bodyRatio;

  /// Must be of length 3. The list defining breakpoints for the
  /// [AdaptiveLayout] the breakpoint is active from the value at the index up
  /// until the value at the next index.
  ///
  /// Defaults to [0, 480, 1024].
  final List<int> breakpoints;

  /// Whether or not the developer wants display animations.
  ///
  /// Defaults to true.
  final bool displayAnimations;

  /// Whether or not the developer wants the smooth entering slide transition on
  /// secondaryBody.
  ///
  /// Defaults to true.
  final bool bodyAnimated;

  /// Whether to orient the body and secondaryBody in horizontal order (true) or
  /// in vertical order (false).
  ///
  /// Defaults to true.
  final bool horizontalBody;

  /// Public helper method to be used for creating a [NavigationRail] from a
  /// list of [NavigationDestination]s. Takes in a [selectedIndex] property for
  /// the current selected item in the [NavigationRail] and [extended] for
  /// whether the [NavigationRail] is extended or not.
  static NavigationRail toNavigationRail(
      {required List<NavigationDestination> destinations,
      int selectedIndex = 0,
      bool extended = false,
      Color backgroundColor = Colors.transparent,
      Widget? leading,
      Widget? trailing}) {
    return NavigationRail(
      leading: leading,
      trailing: trailing,
      backgroundColor: backgroundColor,
      extended: extended,
      selectedIndex: selectedIndex,
      destinations: <NavigationRailDestination>[
        for (NavigationDestination destination in destinations)
          NavigationRailDestination(
            label: Text(destination.label),
            icon: destination.icon,
          )
      ],
    );
  }

  /// Public helper method to be used for creating a [BottomNavigationBar] from
  /// a list of [NavigationDestination]s.
  static BottomNavigationBar toBottomNavigationBar(
      {required List<NavigationDestination> destinations,
      Color selectedItemColor = Colors.black,
      Color backgroundColor = Colors.transparent}) {
    return BottomNavigationBar(
      backgroundColor: backgroundColor,
      selectedItemColor: selectedItemColor,
      items: <BottomNavigationBarItem>[
        for (NavigationDestination destination in destinations)
          BottomNavigationBarItem(
            label: destination.label,
            icon: destination.icon,
          )
      ],
    );
  }

  @override
  State<AdaptiveScaffold> createState() => _AdaptiveScaffoldState();
}


class _AdaptiveScaffoldState extends State<AdaptiveScaffold> {
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

  Widget fadeIn(Widget child, AnimationController animation) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: animation, curve: Curves.easeInCubic),
      child: child,
    );
  }

  Widget fadeOut(Widget child, AnimationController animation) {
    return FadeTransition(
      opacity: CurvedAnimation(parent: ReverseAnimation(animation), curve: Curves.easeInCubic),
      child: child,
    );
  }
  @override
  Widget build(BuildContext context) {
    List<WidgetBuilder?>? bodyList = <WidgetBuilder?>[widget.smallBody ?? widget.body, widget.body, widget.largeBody ?? widget.body];
    List<WidgetBuilder?>? secondaryBodyList = <WidgetBuilder?>[widget.smallSecondaryBody ?? widget.secondaryBody, widget.secondaryBody, widget.largeSecondaryBody ?? widget.secondaryBody];
    if(bodyList.every((WidgetBuilder? e) => e==null)) {
      bodyList = null;
    }
    if(secondaryBodyList.every((WidgetBuilder? e) => e==null)) {
      secondaryBodyList = null;
    }

    return Directionality(
      textDirection: TextDirection.ltr,
      child: AdaptiveLayout(
        horizontalBody: widget.horizontalBody,
        bodyRatio: widget.bodyRatio,
        internalAnimations: widget.bodyAnimated && widget.displayAnimations,
        primaryNavigation: widget.destinations != null && widget.selectedIndex != null
            ? SlotLayout(
                config: <int, SlotLayoutConfig>{
                  widget.breakpoints[0]: SlotLayoutConfig(
                    outAnimation: widget.displayAnimations ? leftInOut : null,
                    key: const Key('primaryNavigation0'),
                    builder: (_) => const SizedBox(
                      width: 0,
                      height: 0,
                    ),
                  ),
                  widget.breakpoints[1]: SlotLayoutConfig(
                    inAnimation: widget.displayAnimations ? leftOutIn : null,
                    key: const Key('primaryNavigation1'),
                    builder: (_) => SizedBox(
                      width: 75,
                      height: MediaQuery.of(context).size.height,
                      child: NavigationRail(
                        selectedIndex: widget.selectedIndex,
                        destinations: widget.destinations!.map(_toRailDestination).toList(),
                      ),
                    ),
                  ),
                  widget.breakpoints[2]: SlotLayoutConfig(
                    inAnimation: widget.displayAnimations ? leftOutIn : null,
                    key: const Key('primaryNavigation2'),
                    builder: (_) => SizedBox(
                      width: 150,
                      height: MediaQuery.of(context).size.height,
                      child: NavigationRail(
                        extended: true,
                        selectedIndex: widget.selectedIndex,
                        destinations: widget.destinations!.map(_toRailDestination).toList(),
                      ),
                    ),
                  ),
                },
              )
            : null,
        bottomNavigation: widget.destinations != null && widget.selectedIndex != null
            ? SlotLayout(
                config: <int, SlotLayoutConfig>{
                  widget.breakpoints[0]: SlotLayoutConfig(
                    inAnimation: widget.displayAnimations ? bottomToTop : null,
                    key: const Key('botnav1'),
                    builder: (_) => BottomNavigationBar(
                      unselectedItemColor: Colors.grey,
                      selectedItemColor: Colors.black,
                      items: widget.destinations!.map(_toBottomNavItem).toList(),
                    ),
                  ),
                  widget.breakpoints[1]: SlotLayoutConfig(
                    outAnimation: widget.displayAnimations ? topToBottom : null,
                    key: const Key('botnavnone'),
                    builder: (_) => const SizedBox(width: 0, height: 0),
                  ),
                },
              )
            : null,
        body: _createSlotFromProperties(bodyList, 'body'),
        secondaryBody: _createSlotFromProperties(secondaryBodyList, 'secondaryBody'),
      ),
    );
  }

  SlotLayout? _createSlotFromProperties(List<WidgetBuilder?>? list, String name) {
    return list != null
        ? SlotLayout(
            config: <int, SlotLayoutConfig?>{
              for (MapEntry<int, WidgetBuilder?> entry in list.asMap().entries)
                if (entry.key == 0 || list[entry.key] != list[entry.key - 1])
                  widget.breakpoints[entry.key]: (entry.value != null)
                      ? SlotLayoutConfig(
                          key: Key('$name${entry.key}'),
                          inAnimation: fadeIn,
                          outAnimation: fadeOut,
                          builder: entry.value!,
                        )
                      : null
            },
          )
        : null;
  }
}

NavigationRailDestination _toRailDestination(NavigationDestination destination) {
  return NavigationRailDestination(
    label: Text(destination.label),
    icon: destination.icon,
  );
}

BottomNavigationBarItem _toBottomNavItem(NavigationDestination destination) {
  return BottomNavigationBarItem(
    label: destination.label,
    icon: destination.icon,
  );
}
