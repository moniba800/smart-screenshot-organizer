
import 'package:flutter/material.dart';
import 'data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        elevation: 2,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Smart Screenshot Organizer',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Organize your screenshots easily',
              style: TextStyle(fontSize: 11),
            ),
          ],
        ),
        leading: const Icon(Icons.photo_library),
      ),
      body: shots.isEmpty
          ? const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.image_not_supported,
              size: 80,
              color: Colors.grey,
            ),
            SizedBox(height: 12),
            Text(
              'No screenshots yet',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Add screenshots to organize them',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      )
          : ShotGrid(
        items: shots,
        onChanged: () => setState(() {}),
      ),
    );
  }
}
