import 'package:adaptive_layout_api/adaptive_scaffold.dart';
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
      home:
      AdaptiveScaffold(
        breakpoints: const [0, 500, 1000],
        selectedIndex: 0,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.inbox), label: 'hello'),
          NavigationDestination(icon: Icon(Icons.article), label: 'hello1'),
          NavigationDestination(icon: Icon(Icons.chat), label: 'hello2'),
          NavigationDestination(icon: Icon(Icons.video_call), label: 'hello3'),
        ],
        body: [
          ListView.builder(
            itemCount: allItems.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 250,
                color: Colors.red,
              ),
            ),
          ),
          ListView.builder(
            itemCount: allItems.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                color: Colors.red,
              ),
            ),
          )
          ,null
        ],
        secondaryBody: [
          ListView.builder(
            itemCount: allItems.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 250,
                color: Colors.red,
              ),
            ),
          ),
          ListView.builder(
            itemCount: allItems.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                color: Colors.red,
              ),
            ),
          )
          ,null
        ],
      )
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
      image: 'https://images.unsplash.com/photo-1463453091185-61582044d556?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTJ8fHByb2ZpbGUlMjBwaWN0dXJlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=400&q=60'),
  Item(
      name: 'Lily Mac',
      time: '2 hours',
      title: 'This food show is made for you',
      body:
          "3I think it's time for us to finally try that new noodle shop downtown that doesn't use menus. Anyone else have other suggestions for dinner club this week? I'm so intruiged by this idea of a noodle restaurant where no one gets to order for themselves - could be fun, or terrible, or both :)",
      image: 'https://images.unsplash.com/photo-1603415526960-f7e0328c63b1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60'),
  Item(
      name: 'Lani Mansell',
      time: '10 min',
      title: 'Dinner Club 4',
      body:
          "4I think it's time for us to finally try that new noodle shop downtown that doesn't use menus. Anyone else have other suggestions for dinner club this week? I'm so intruiged by this idea of a noodle restaurant where no one gets to order for themselves - could be fun, or terrible, or both :)",
      image: 'https://images.unsplash.com/photo-1629467057571-42d22d8f0cbd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTN8fHByb2ZpbGUlMjBwaWN0dXJlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=400&q=60'),
  Item(
      name: 'Caitlyn Mars',
      time: '10 min',
      title: 'This food ',
      body:
          "1I think it's time for us to finally try that new noodle shop downtown that doesn't use menus. Anyone else have other suggestions for dinner club this week? I'm so intruiged by this idea of a noodle restaurant where no one gets to order for themselves - could be fun, or terrible, or both :)",
      image: 'https://images.unsplash.com/photo-1619895862022-09114b41f16f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8cHJvZmlsZSUyMHBpY3R1cmV8ZW58MHx8MHx8&auto=format&fit=crop&w=400&q=60'),
  Item(
      name: 'Robin Goff',
      time: '10 min',
      title: 'Dinner Club 5',
      body:
          "5I think it's time for us to finally try that new noodle shop downtown that doesn't use menus. Anyone else have other suggestions for dinner club this week? I'm so intruiged by this idea of a noodle restaurant where no one gets to order for themselves - could be fun, or terrible, or both :)",
      image: 'https://images.unsplash.com/photo-1518020382113-a7e8fc38eac9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fHByb2ZpbGUlMjBwaWN0dXJlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=400&q=60'),
  Item(
      name: 'Klara Blan',
      time: '10 min',
      title: 'Dinner Club 6',
      body:
          "6I think it's time for us to finally try that new noodle shop downtown that doesn't use menus. Anyone else have other suggestions for dinner club this week? I'm so intruiged by this idea of a noodle restaurant where no one gets to order for themselves - could be fun, or terrible, or both :)",
      image: 'https://images.unsplash.com/photo-1518020382113-a7e8fc38eac9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fHByb2ZpbGUlMjBwaWN0dXJlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=400&q=60'),
  Item(
      name: 'Bianka Bass',
      time: '10 min',
      title: 'Dinner Club 7',
      body:
          "7I think it's time for us to finally try that new noodle shop downtown that doesn't use menus. Anyone else have other suggestions for dinner club this week? I'm so intruiged by this idea of a noodle restaurant where no one gets to order for themselves - could be fun, or terrible, or both :)",
      image: 'https://images.unsplash.com/photo-1518020382113-a7e8fc38eac9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fHByb2ZpbGUlMjBwaWN0dXJlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=400&q=60'),
  Item(
      name: 'Beau Kline',
      time: '10 min',
      title: 'Dinner Club 8',
      body:
          "8I think it's time for us to finally try that new noodle shop downtown that doesn't use menus. Anyone else have other suggestions for dinner club this week? I'm so intruiged by this idea of a noodle restaurant where no one gets to order for themselves - could be fun, or terrible, or both :)",
      image: 'https://images.unsplash.com/photo-1518020382113-a7e8fc38eac9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fHByb2ZpbGUlMjBwaWN0dXJlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=400&q=60'),
  Item(
      name: 'Fran Martin',
      time: '10 min',
      title: 'Dinner Club 9',
      body:
          "9I think it's time for us to finally try that new noodle shop downtown that doesn't use menus. Anyone else have other suggestions for dinner club this week? I'm so intruiged by this idea of a noodle restaurant where no one gets to order for themselves - could be fun, or terrible, or both :)",
      image: 'https://images.unsplash.com/photo-1518020382113-a7e8fc38eac9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTh8fHByb2ZpbGUlMjBwaWN0dXJlfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=400&q=60'),
];
