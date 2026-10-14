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
    if (shots.isEmpty) {
      return const Center(child: Text('Koi screenshot nahi hai'));
    }
    return GridView.builder(
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 90),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: shots.length,
      itemBuilder: (context, i) {
        final s = shots[i];
        return InkWell(
          onTap: () async {
            await showShotDialog(context, s);
            setState(() {});
          },
          child: Container(
            decoration: BoxDecoration(
              color: s.color.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(s.icon, size: 60, color: s.color),
                const SizedBox(height: 10),
                Text(s.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 6),
                Chip(label: Text(s.category)),
              ],
            ),
          ),
        );
      },
    );
  }
}