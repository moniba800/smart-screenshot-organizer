
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notificationsEnabled = true;
  bool darkModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const CircleAvatar(
            radius: 40,
            backgroundColor: Colors.indigo,
            child: Icon(
              Icons.person,
              size: 45,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 12),

          const Center(
            child: Text(
              'Smart Screenshot Organizer',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const SizedBox(height: 25),

          const Text(
            'GENERAL',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          SwitchListTile(
            secondary: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            subtitle: const Text('Enable or disable notifications'),
            value: notificationsEnabled,
            onChanged: (value) {
              setState(() {
                notificationsEnabled = value;
              });
            },
          ),

          SwitchListTile(
            secondary: const Icon(Icons.dark_mode),
            title: const Text('Dark Mode'),
            subtitle: const Text('Change app appearance'),
            value: darkModeEnabled,
            onChanged: (value) {
              setState(() {
                darkModeEnabled = value;
              });
            },
          ),

          const Divider(height: 30),

          const Text(
            'ABOUT',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          const ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('About App'),
            subtitle: Text('Smart Screenshot Organizer'),
          ),

          const ListTile(
            leading: Icon(Icons.verified_outlined),
            title: Text('App Version'),
            subtitle: Text('Version 1.0.0'),
          ),
        ],
      ),
    );
  }
}
