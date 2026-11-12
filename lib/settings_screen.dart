import 'package:flutter/material.dart';
import 'data.dart';
import 'app_state.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<bool> _confirm(String title, String message) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  void _snack(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  void _applySort(String value) {
    setState(() {
      sortBy = value;
      shots.sort((a, b) => value == 'name'
          ? a.title.toLowerCase().compareTo(b.title.toLowerCase())
          : a.category.toLowerCase().compareTo(b.category.toLowerCase()));
    });
    _snack('Sorted by $value');
  }

  Future<void> _clearAll() async {
    final ok = await _confirm('Clear data',
        'All screenshots will be removed from the app list. This cannot be undone.');
    if (!ok) return;
    setState(() => shots.clear());
    _snack('All data cleared');
  }

  Widget _header(String text) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
    child: Text(text,
        style: const TextStyle(
            fontWeight: FontWeight.bold, color: Colors.indigo)),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          _header('Appearance'),
          ValueListenableBuilder<ThemeMode>(
            valueListenable: themeNotifier,
            builder: (context, mode, _) => SwitchListTile(
              secondary: const Icon(Icons.dark_mode),
              title: const Text('Dark mode'),
              value: mode == ThemeMode.dark,
              onChanged: (v) => themeNotifier.value =
              v ? ThemeMode.dark : ThemeMode.light,
            ),
          ),
          const Divider(),
          _header('Sort screenshots by'),
          RadioListTile<String>(
            title: const Text('Name'),
            value: 'name',
            groupValue: sortBy,
            onChanged: (v) => _applySort(v!),
          ),
          RadioListTile<String>(
            title: const Text('Category'),
            value: 'category',
            groupValue: sortBy,
            onChanged: (v) => _applySort(v!),
          ),
          const Divider(),
          _header('Data'),
          ListTile(
            leading: const Icon(Icons.photo_library, color: Colors.indigo),
            title: const Text('Total screenshots'),
            trailing: Text('${shots.length}'),
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: const Text('Clear data'),
            subtitle: const Text('Removes all screenshots from the app list'),
            onTap: _clearAll,
          ),
          const Divider(),
          _header('About'),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Smart Screenshot Organizer'),
            subtitle: const Text('Version 1.0.0'),
            onTap: () => showAboutDialog(
              context: context,
              applicationName: 'Smart Screenshot Organizer',
              applicationVersion: '1.0.0',
              children: const [
                Text(
                    'Organize your screenshots by category and search them quickly.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}