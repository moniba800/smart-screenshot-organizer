import 'package:flutter/material.dart';
import 'data.dart';
import 'category_detail_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  int _count(String c) => shots.where((s) => s.category == c).length;

  // old == null means Add, otherwise Edit
  Future<void> _showCategoryDialog({String? old}) async {
    final controller = TextEditingController(text: old ?? '');
    String? error;

    final result = await showDialog<String>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Text(old == null ? 'Add category' : 'Edit category'),
          content: TextField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              labelText: 'Category name',
              errorText: error,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final name = controller.text.trim();
                if (name.isEmpty) {
                  setDialogState(() => error = 'Name cannot be empty');
                  return;
                }
                final duplicate = categories.any((c) =>
                c.toLowerCase() == name.toLowerCase() &&
                    c.toLowerCase() != (old ?? '').toLowerCase());
                if (duplicate) {
                  setDialogState(() => error = 'Category already exists');
                  return;
                }
                Navigator.pop(ctx, name);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
    controller.dispose();

    if (result == null || !mounted) return;
    setState(() {
      if (old == null) {
        categoryIcons[result] = Icons.folder;
      } else {
        final entries = categoryIcons.entries.toList();
        categoryIcons.clear();
        for (final e in entries) {
          categoryIcons[e.key == old ? result : e.key] = e.value;
        }
        for (final s in shots) {
          if (s.category == old) s.category = result;
        }
      }
    });
  }

  Future<void> _delete(String c) async {
    final n = _count(c);
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete category'),
        content: Text(n == 0
            ? 'Delete "$c"?'
            : 'Delete "$c"? Its $n screenshot(s) will also be removed from the list.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (ok != true || !mounted) return;
    setState(() {
      categoryIcons.remove(c);
      shots.removeWhere((s) => s.category == c);
    });
  }

  @override
  Widget build(BuildContext context) {
    final cats = categories;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCategoryDialog(),
        child: const Icon(Icons.add),
      ),
      body: cats.isEmpty
          ? const Center(child: Text('No categories yet. Tap + to add one.'))
          : ListView.builder(
        itemCount: cats.length,
        itemBuilder: (context, i) {
          final c = cats[i];
          return Card(
            margin:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: ListTile(
              leading: Icon(categoryIcons[c] ?? Icons.folder,
                  color: Colors.indigo),
              title: Text(c),
              subtitle: Text('${_count(c)} screenshot(s)'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => CategoryDetailScreen(category: c)),
              ).then((_) => setState(() {})),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () => _showCategoryDialog(old: c),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _delete(c),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}