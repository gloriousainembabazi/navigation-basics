import 'package:flutter/material.dart';
import '../main.dart'; // For AppRoutes

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.purple,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 20),
          const Center(
            child: Icon(
              Icons.settings,
              size: 80,
              color: Colors.purple,
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Settings',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          
          // Settings options
          _buildSettingsTile(
            Icons.person,
            'Account Settings',
            'Manage your account',
            () {},
          ),
          _buildSettingsTile(
            Icons.notifications,
            'Notifications',
            'Configure alerts',
            () {},
          ),
          _buildSettingsTile(
            Icons.lock,
            'Privacy',
            'Security settings',
            () {},
          ),
          _buildSettingsTile(
            Icons.language,
            'Language',
            'English',
            () {},
          ),
          _buildSettingsTile(
            Icons.info,
            'About',
            'App version 1.0.0',
            () {},
          ),
          
          const SizedBox(height: 30),
          
          // Navigation back to home
          ElevatedButton.icon(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.home,
                (route) => false,
              );
            },
            icon: const Icon(Icons.home),
            label: const Text('Go to Home'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: Colors.purple),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}