import 'package:flutter/material.dart';
import 'data.dart';

class CategoryDetailScreen extends StatefulWidget {
  final String category;
  const CategoryDetailScreen({super.key, required this.category});

  @override
  State<CategoryDetailScreen> createState() => _CategoryDetailScreenState();
}

class _CategoryDetailScreenState extends State<CategoryDetailScreen> {
  @override
  Widget build(BuildContext context) {
    final items = shots.where((s) => s.category == widget.category).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: items.isEmpty
          ? const Center(child: Text('No screenshots in this category'))
          : ShotGrid(items: items, onChanged: () => setState(() {})),
    );
  }
}