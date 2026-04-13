import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
          onPressed: () => context.canPop() ? context.pop() : context.go('/dashboard'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => context.go('/dashboard'),
            tooltip: 'Dashboard (Clear Stack)',
          ),
        ],
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
            context,
            Icons.person,
            'Account Settings',
            'Manage your account',
            () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Account Settings')),
              );
            },
          ),
          _buildSettingsTile(
            context,
            Icons.notifications,
            'Notifications',
            'Configure alerts',
            () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notification Settings')),
              );
            },
          ),
          _buildSettingsTile(
            context,
            Icons.lock,
            'Privacy',
            'Security settings',
            () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Privacy Settings')),
              );
            },
          ),
          _buildSettingsTile(
            context,
            Icons.language,
            'Language',
            'English',
            () {
              _showLanguageDialog(context);
            },
          ),
          _buildSettingsTile(
            context,
            Icons.info,
            'About',
            'App version 1.0.0',
            () {
              context.push('/about');
            },
          ),
          
          const SizedBox(height: 30),
          
          // Navigation back to dashboard using go() (clears stack)
          ElevatedButton.icon(
            onPressed: () {
              context.go('/dashboard');
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Returned to Dashboard - Stack cleared'),
                  backgroundColor: Colors.purple,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            icon: const Icon(Icons.dashboard),
            label: const Text('Go to Dashboard'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          
          const SizedBox(height: 10),
          
          // Current route info
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.purple.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'Current Route: ${GoRouterState.of(context).uri.toString()}',
              style: const TextStyle(
                fontSize: 11,
                fontFamily: 'monospace',
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.purple),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('English'),
              onTap: () {
                context.pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Language changed to English')),
                );
              },
            ),
            ListTile(
              title: const Text('French'),
              onTap: () {
                context.pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Langue changée en français')),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}