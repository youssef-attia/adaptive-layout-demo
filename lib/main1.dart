import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin, ChangeNotifier {
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

  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const List<NavigationDestination> destinations = [
      NavigationDestination(label: 'Inbox', icon: Icon(Icons.inbox, color: Colors.black)),
      NavigationDestination(label: 'Articles', icon: Icon(Icons.article_outlined, color: Colors.black)),
      NavigationDestination(label: 'Chat', icon: Icon(Icons.chat_bubble_outline, color: Colors.black)),
      NavigationDestination(label: 'Video', icon: Icon(Icons.video_call_outlined, color: Colors.black)),
    ];
    return Scaffold(
      body: SafeArea(
        child:
AdaptiveLayout(
  primaryNavigation: SlotLayout(
    config: {
      Breakpoints.small: SlotLayoutConfig(key: const Key('pnav'), builder: (_) => const SizedBox.shrink()),
      Breakpoints.medium: SlotLayoutConfig(
        inAnimation: leftOutIn,
        key: const Key('pnav1'),
        builder: (_) => AdaptiveScaffold.toNavigationRail(destinations: destinations),
      ),
      Breakpoints.large: SlotLayoutConfig(
        key: const Key('pnav2'),
        inAnimation: leftOutIn,
        builder: (_) => AdaptiveScaffold.toNavigationRail(extended: true, destinations: destinations),
      ),
    },
  ),
  body: SlotLayout(
    config: {
      Breakpoints.small: SlotLayoutConfig(
        key: const Key('body'),
        builder: (_) => ListView.builder(
          itemCount: allItems.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: const Color.fromARGB(255, 255, 201, 197),
              height: 400,
            ),
          ),
        ),
      ),
      Breakpoints.medium: SlotLayoutConfig(
        key: const Key('body1'),
        builder: (_) => GridView.count(
          crossAxisCount: 2,
          children: allItems.map((item) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: const Color.fromARGB(255, 255, 201, 197),
              height: 400,
            ),
          )).toList(),
        ),
      ),
    },
  ),
  bottomNavigation: SlotLayout(
    config: {
      Breakpoints.small: SlotLayoutConfig(
        key: const Key('botnav'),
        inAnimation: bottomToTop,
        builder: (_) => AdaptiveScaffold.toBottomNavigationBar(destinations: destinations),
      ),
      Breakpoints.medium: SlotLayoutConfig(key: const Key('botnav1'), builder: (_) => const SizedBox.shrink()),
    },
  ),
),
      ),
    );
  }
}

class Item {
  const Item({
    required this.name,
    required this.time,
    required this.title,
    required this.body,
    required this.image,
  });

  final String name;
  final String time;
  final String title;
  final String body;
  final String image;
}

const List<Item> allItems = [
  Item(
      name: 'So Duri',
      time: '20 min',
      title: 'Dinner Club',
      body:
          "I think it's time for us to finally try that new noodle shop downtown that doesn't use menus. Anyone else have other suggestions for dinner club this week? I'm so intruiged by this idea of a noodle restaurant where no one gets to order for themselves - could be fun, or terrible, or both :)",
      image: 'https://images.unsplash.com/photo-1463453091185-61582044d556?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fHByb2ZpbGUlMjBwaWN0dXJlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60'),
  Item(
      name: 'Lily MacDonald',
      time: '2 hours',
      title: 'This food show is made for you',
      body:
          "3I think it's time for us to finally try that new noodle shop downtown that doesn't use menus. Anyone else have other suggestions for dinner club this week? I'm so intruiged by this idea of a noodle restaurant where no one gets to order for themselves - could be fun, or terrible, or both :)",
      image: 'https://images.unsplash.com/photo-1603415526960-f7e0328c63b1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60'),
  Item(
      name: 'Lani Mansell',
      time: '10 min',
      title: 'Dinner Club 4',
      body:
          "4I think it's time for us to finally try that new noodle shop downtown that doesn't use menus. Anyone else have other suggestions for dinner club this week? I'm so intruiged by this idea of a noodle restaurant where no one gets to order for themselves - could be fun, or terrible, or both :)",
      image: 'https://images.unsplash.com/photo-1629467057571-42d22d8f0cbd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTN8fHByb2ZpbGUlMjBwaWN0dXJlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60'),
  Item(
      name: 'Caitlyn Marshall',
      time: '10 min',
      title: 'This food ',
      body:
          "1I think it's time for us to finally try that new noodle shop downtown that doesn't use menus. Anyone else have other suggestions for dinner club this week? I'm so intruiged by this idea of a noodle restaurant where no one gets to order for themselves - could be fun, or terrible, or both :)",
      image: 'https://images.unsplash.com/photo-1619895862022-09114b41f16f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60'),
  Item(
      name: 'Robin Goff',
      time: '10 min',
      title: 'Dinner Club 5',
      body:
          "5I think it's time for us to finally try that new noodle shop downtown that doesn't use menus. Anyone else have other suggestions for dinner club this week? I'm so intruiged by this idea of a noodle restaurant where no one gets to order for themselves - could be fun, or terrible, or both :)",
      image: 'https://images.unsplash.com/photo-1518020382113-a7e8fc38eac9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fHByb2ZpbGUlMjBwaWN0dXJlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60'),
  Item(
      name: 'Klara Blankenship',
      time: '10 min',
      title: 'Dinner Club 6',
      body:
          "6I think it's time for us to finally try that new noodle shop downtown that doesn't use menus. Anyone else have other suggestions for dinner club this week? I'm so intruiged by this idea of a noodle restaurant where no one gets to order for themselves - could be fun, or terrible, or both :)",
      image: 'https://images.unsplash.com/photo-1518020382113-a7e8fc38eac9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fHByb2ZpbGUlMjBwaWN0dXJlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60'),
  Item(
      name: 'Bianka Bass',
      time: '10 min',
      title: 'Dinner Club 7',
      body:
          "7I think it's time for us to finally try that new noodle shop downtown that doesn't use menus. Anyone else have other suggestions for dinner club this week? I'm so intruiged by this idea of a noodle restaurant where no one gets to order for themselves - could be fun, or terrible, or both :)",
      image: 'https://images.unsplash.com/photo-1518020382113-a7e8fc38eac9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fHByb2ZpbGUlMjBwaWN0dXJlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60'),
  Item(
      name: 'Beau Kline',
      time: '10 min',
      title: 'Dinner Club 8',
      body:
          "8I think it's time for us to finally try that new noodle shop downtown that doesn't use menus. Anyone else have other suggestions for dinner club this week? I'm so intruiged by this idea of a noodle restaurant where no one gets to order for themselves - could be fun, or terrible, or both :)",
      image: 'https://images.unsplash.com/photo-1518020382113-a7e8fc38eac9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fHByb2ZpbGUlMjBwaWN0dXJlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60'),
  Item(
      name: 'Francisco Martin',
      time: '10 min',
      title: 'Dinner Club 9',
      body:
          "9I think it's time for us to finally try that new noodle shop downtown that doesn't use menus. Anyone else have other suggestions for dinner club this week? I'm so intruiged by this idea of a noodle restaurant where no one gets to order for themselves - could be fun, or terrible, or both :)",
      image: 'https://images.unsplash.com/photo-1518020382113-a7e8fc38eac9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fHByb2ZpbGUlMjBwaWN0dXJlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60'),
];
