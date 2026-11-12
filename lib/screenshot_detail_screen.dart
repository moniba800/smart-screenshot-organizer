import 'package:flutter/material.dart';
import 'data.dart';

class ScreenshotDetailScreen extends StatefulWidget {
  final Shot shot;

  const ScreenshotDetailScreen({super.key, required this.shot});

  @override
  State<ScreenshotDetailScreen> createState() => _ScreenshotDetailScreenState();
}

class _ScreenshotDetailScreenState extends State<ScreenshotDetailScreen> {
  final TextEditingController _tagController = TextEditingController();

  Shot get shot => widget.shot;

  @override
  void dispose() {
    _tagController.dispose();
    super.dispose();
  }

  void _showMessage(String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(text)));
  }

  // Add a tag with validation
  void _addTag() {
    final tag = _tagController.text.trim();

    if (tag.isEmpty) {
      _showMessage('Tag cannot be empty');
      return;
    }
    if (shot.tags.any((t) => t.toLowerCase() == tag.toLowerCase())) {
      _showMessage('This tag already exists');
      return;
    }

    setState(() => shot.tags.add(tag));
    _tagController.clear();
    _showMessage('Tag added');
  }

  void _removeTag(String tag) {
    setState(() => shot.tags.remove(tag));
  }

  // Move to another category
  Future<void> _moveShot() async {
    final selected = await showDialog<String>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: const Text('Move to category'),
        children: categories
            .map(
              (c) => SimpleDialogOption(
            onPressed: () => Navigator.pop(ctx, c),
            child: Row(
              children: [
                Icon(categoryIcons[c]),
                const SizedBox(width: 12),
                Text(c),
                if (c == shot.category) ...[
                  const Spacer(),
                  const Icon(Icons.check, color: Colors.green),
                ],
              ],
            ),
          ),
        )
            .toList(),
      ),
    );

    if (selected != null && selected != shot.category) {
      setState(() => shot.category = selected);
      _showMessage('Moved to $selected');
    }
  }

  // Delete with confirmation
  Future<void> _deleteShot() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete screenshot?'),
        content: Text('"${shot.title}" will be removed permanently.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirm == true) {
      shots.remove(shot);
      if (!mounted) return;
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Screenshot Details'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Preview
            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: shot.color.shade100,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(shot.icon, size: 100, color: shot.color),
            ),
            const SizedBox(height: 16),

            // Title
            Text(
              shot.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // Category
            Row(
              children: [
                const Icon(Icons.folder, size: 20, color: Colors.grey),
                const SizedBox(width: 6),
                Text('Category: ${shot.category}'),
              ],
            ),
            const SizedBox(height: 20),

            // Tags
            const Text(
              'Tags',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            if (shot.tags.isEmpty)
              const Text('No tags yet', style: TextStyle(color: Colors.grey))
            else
              Wrap(
                spacing: 8,
                children: shot.tags
                    .map(
                      (t) => Chip(
                    label: Text(t),
                    onDeleted: () => _removeTag(t),
                  ),
                )
                    .toList(),
              ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _tagController,
                    decoration: const InputDecoration(
                      hintText: 'Add a tag',
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    onSubmitted: (_) => _addTag(),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _addTag,
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Actions
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _moveShot,
                    icon: const Icon(Icons.drive_file_move),
                    label: const Text('Move'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _deleteShot,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    icon: const Icon(Icons.delete),
                    label: const Text('Delete'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}