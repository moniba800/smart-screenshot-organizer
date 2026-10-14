import 'package:flutter/material.dart';

class Shot {
  final String title;
  final String category;
  final IconData icon;
  final Color color;
  Shot(this.title, this.category, this.icon, this.color);
}

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

final Map<String, IconData> categoryIcons = {
  'Chats': Icons.chat_bubble,
  'Receipts': Icons.receipt,
  'Study': Icons.school,
  'Memes': Icons.emoji_emotions,
};

extension ColorShade on Color {
  Color get shade100 {
    final c = this;
    if (c is MaterialColor) return c.shade100;
    return c.withAlpha(60);
  }
}

Future<void> showShotDialog(BuildContext context, Shot shot) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Row(
        children: [
          Icon(shot.icon, color: shot.color),
          const SizedBox(width: 10),
          Expanded(child: Text(shot.title)),
        ],
      ),
      content: Text('Category: ${shot.category}'),
      actions: [
        TextButton.icon(
          onPressed: () {
            shots.remove(shot);
            Navigator.pop(ctx);
          },
          icon: const Icon(Icons.delete),
          label: const Text('Delete'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: const Text('Close'),
        ),
      ],
    ),
  );
}