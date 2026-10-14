import 'package:flutter/material.dart';
import 'data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: categoryIcons.entries.map((e) {
        final count = shots.where((s) => s.category == e.key).length;
        return Card(
          child: ListTile(
            leading: Icon(e.value, color: Colors.indigo, size: 32),
            title: Text(e.key),
            subtitle: Text('$count screenshots'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          ),
        );
      }).toList(),
    );
  }
}