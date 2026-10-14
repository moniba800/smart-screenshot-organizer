import 'package:flutter/material.dart';
import 'data.dart';
import 'home_screen.dart';
import 'categories_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;

  final titles = ['My Screenshots', 'Categories'];

  Widget currentScreen() {
    if (index == 0) return const HomeScreen();
    return const CategoriesScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[index]),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: currentScreen(),
      floatingActionButton: index == 0
          ? FloatingActionButton(
        onPressed: () {
          setState(() {
            shots.add(Shot('New Screenshot ${shots.length + 1}', 'Memes',
                Icons.image, Colors.cyan));
          });
        },
        child: const Icon(Icons.add_a_photo),
      )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        type: BottomNavigationBarType.fixed,
        onTap: (i) => setState(() => index = i),
        selectedItemColor: Colors.indigo,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.folder), label: 'Categories'),
        ],
      ),
    );
  }
}