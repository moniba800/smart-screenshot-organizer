import 'package:flutter/material.dart';
import 'screenshot_detail_screen.dart';

// Model for one screenshot
class Shot {
  String title;
  String category;
  final IconData icon;
  final Color color;
  List<String> tags;

  Shot(
      this.title,
      this.category,
      this.icon,
      this.color, {
        List<String>? tags,
      }) : tags = tags ?? [];

  String get name => title;
}

// Demo screenshots
final List<Shot> shots = [
  Shot('Chat with Ali', 'Chats', Icons.chat, Colors.green),
  Shot('Bank Receipt', 'Receipts', Icons.receipt_long, Colors.orange),
  Shot('Flutter Tutorial', 'Study', Icons.menu_book, Colors.blue),
  Shot('Funny Meme', 'Memes', Icons.emoji_emotions, Colors.purple),
  Shot('Online Order', 'Receipts', Icons.shopping_bag, Colors.deepOrange),
  Shot('Group Chat', 'Chats', Icons.groups, Colors.teal),
  Shot('Exam Notes', 'Study', Icons.edit_note, Colors.indigo),
  Shot('Cat Meme', 'Memes', Icons.pets, Colors.pink),
];

// Category icons
final Map<String, IconData> categoryIcons = {
  'Chats': Icons.chat_bubble,
  'Receipts': Icons.receipt,
  'Study': Icons.school,
  'Memes': Icons.emoji_emotions,
};

// Category names (always follows categoryIcons)
List<String> get categories => categoryIcons.keys.toList();

// Light color shade helper
extension ColorShade on Color {
  Color get shade100 {
    final c = this;
    if (c is MaterialColor) {
      return c.shade100;
    }
    return c.withAlpha(60);
  }
}

// Open screenshot detail screen
Future<void> showShotDialog(BuildContext context, Shot shot) {
  return Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => ScreenshotDetailScreen(shot: shot),
    ),
  );
}

// Screenshot grid
class ShotGrid extends StatelessWidget {
  final List<Shot> items;
  final VoidCallback onChanged;

  const ShotGrid({
    super.key,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: items.length,
      itemBuilder: (context, i) {
        final s = items[i];

        return InkWell(
          onTap: () async {
            await showShotDialog(context, s);
            onChanged();
          },
          child: Container(
            decoration: BoxDecoration(
              color: s.color.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(s.icon, size: 50, color: s.color),
                const SizedBox(height: 8),
                Text(
                  s.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
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