import 'package:flutter/material.dart';
import '../main.dart'; // For AppRoutes

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Navigation concepts to demonstrate
  final List<Map<String, dynamic>> navigationItems = const [
    {
      'title': 'Basic Navigation',
      'subtitle': 'Navigator.push() and Navigator.pop()',
      'route': '/second',
      'icon': Icons.navigation,
      'color': Colors.blue,
      'args': {
        'name': 'John Musisi',
        'course': 'Computer Science',
        'year': 3,
        'gpa': 3.8
      }
    },
    {
      'title': 'Passing Data',
      'subtitle': 'Constructor parameters between screens',
      'route': '/second',
      'icon': Icons.data_usage,
      'color': Colors.orange,
      'args': {
        'name': 'Sarah Nabatanzi',
        'course': 'Software Engineering',
        'year': 2,
        'gpa': 3.9
      }
    },
    {
      'title': 'Named Routes',
      'subtitle': 'Using route constants and pushNamed()',
      'route': '/third',
      'icon': Icons.route,
      'color': Colors.purple,
      'args': {
        'name': 'Michael Okello',
        'course': 'Information Technology',
        'info': 'Using named routes with arguments'
      }
    },
    {
      'title': 'Login Screen',
      'subtitle': 'Push replacement navigation',
      'route': '/login',
      'icon': Icons.login,
      'color': Colors.green,
    },
    {
      'title': 'Register Screen',
      'subtitle': 'Dialog navigation demo',
      'route': '/register',
      'icon': Icons.app_registration,
      'color': Colors.teal,
    },
    {
      'title': 'Settings Screen',
      'subtitle': 'App configuration',
      'route': '/settings',
      'icon': Icons.settings,
      'color': Colors.grey,
    },
    {
      'title': 'About Screen',
      'subtitle': 'App information',
      'route': '/about',
      'icon': Icons.info,
      'color': Colors.indigo,
    },
    {
      'title': 'Contact Screen',
      'subtitle': 'Get in touch with us',
      'route': '/contact',
      'icon': Icons.contact_mail,
      'color': Colors.pink,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Concepts'),
        backgroundColor: Colors.purple,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.settings);
            },
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple.shade700, Colors.purple.shade200],
          ),
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: navigationItems.length,
          itemBuilder: (context, index) {
            final item = navigationItems[index];
            return Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: item['color'].withOpacity(0.2),
                  child: Icon(
                    item['icon'],
                    color: item['color'],
                  ),
                ),
                title: Text(
                  item['title'],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(item['subtitle']),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: item['color'],
                  size: 16,
                ),
                onTap: () {
                  if (item.containsKey('args')) {
                    // Navigate with arguments
                    Navigator.pushNamed(
                      context,
                      item['route'],
                      arguments: item['args'],
                    );
                  } else {
                    // Simple navigation
                    Navigator.pushNamed(context, item['route']);
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.purple.shade700, Colors.purple.shade400],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.school, size: 30, color: Colors.purple),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Navigation Demo',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  'Learning Flutter Navigation',
                  style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: Colors.purple),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.login, color: Colors.green),
            title: const Text('Login'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.login);
            },
          ),
          ListTile(
            leading: const Icon(Icons.app_registration, color: Colors.teal),
            title: const Text('Register'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.register);
            },
          ),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.indigo),
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.about);
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail, color: Colors.pink),
            title: const Text('Contact'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.contact);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.grey),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, AppRoutes.settings);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              _showLogoutDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.login,
                (route) => false, // Clear entire stack
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}