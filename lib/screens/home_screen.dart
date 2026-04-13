import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.purple,
        centerTitle: true,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: 'Navigation Menu',
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.go('/login');
            },
            tooltip: 'Logout',
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple.shade50, Colors.white],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.dashboard,
                  size: 80,
                  color: Colors.purple,
                ),
                const SizedBox(height: 24),
                const Text(
                  'Welcome to Dashboard!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'You have successfully logged in.',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 48),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavButton(
                      context,
                      'About',
                      Icons.info,
                      '/about',
                      Colors.blue,
                    ),
                    _buildNavButton(
                      context,
                      'Contact',
                      Icons.contact_mail,
                      '/contact',
                      Colors.green,
                    ),
                    _buildNavButton(
                      context,
                      'Clear Stack',
                      Icons.clear_all,
                      '/clear-stack',
                      Colors.red,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Column(
                    children: [
                      Text(
                        '💡 Navigation Tip:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '• Use context.go() to replace stack (no back button)\n'
                        '• Use context.push() to add to stack (back works)',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(
    BuildContext context,
    String label,
    IconData icon,
    String route,
    Color color,
  ) {
    return Column(
      children: [
        FloatingActionButton.small(
          heroTag: label,
          onPressed: () => context.push(route),
          backgroundColor: color,
          child: Icon(icon),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
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
                  'go_router Navigation Demo',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  'Ainembabazi Glorious',
                  style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14),
                ),
              ],
            ),
          ),
          // Main Sections
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('MAIN', style: TextStyle(color: Colors.grey, fontSize: 12)),
          ),
          ListTile(
            leading: const Icon(Icons.dashboard, color: Colors.purple),
            title: const Text('Dashboard'),
            onTap: () {
              Navigator.pop(context);
              context.go('/dashboard');
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_bag, color: Colors.orange),
            title: const Text('Products'),
            onTap: () {
              Navigator.pop(context);
              context.go('/products');
            },
          ),
          ListTile(
            leading: const Icon(Icons.explore, color: Colors.green),
            title: const Text('Explore'),
            onTap: () {
              Navigator.pop(context);
              context.go('/explore');
            },
          ),
          ListTile(
            leading: const Icon(Icons.person, color: Colors.blue),
            title: const Text('Profile'),
            onTap: () {
              Navigator.pop(context);
              context.go('/profile');
            },
          ),
          const Divider(),
          
          // Navigation Concepts
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('NAVIGATION CONCEPTS', style: TextStyle(color: Colors.grey, fontSize: 12)),
          ),
          ListTile(
            leading: const Icon(Icons.navigation, color: Colors.teal),
            title: const Text('Basic Navigation'),
            subtitle: const Text('push(), pop(), go()'),
            onTap: () {
              Navigator.pop(context);
              context.push('/basic-navigation');
            },
          ),
          ListTile(
            leading: const Icon(Icons.data_usage, color: Colors.indigo),
            title: const Text('Passing Data'),
            subtitle: const Text('Path params, query params, extra'),
            onTap: () {
              Navigator.pop(context);
              context.push('/passing-data');
            },
          ),
          ListTile(
            leading: const Icon(Icons.architecture, color: Colors.deepPurple),
            title: const Text('Arguments Demo'),
            subtitle: const Text('Using state.extra'),
            onTap: () {
              Navigator.pop(context);
              context.push('/arguments');
            },
          ),
          ListTile(
            leading: const Icon(Icons.clear_all, color: Colors.red),
            title: const Text('Clear Stack Demo'),
            subtitle: const Text('context.go() vs push()'),
            onTap: () {
              Navigator.pop(context);
              context.push('/clear-stack');
            },
          ),
          ListTile(
            leading: const Icon(Icons.chat, color: Colors.pink),
            title: const Text('Dialog Navigation'),
            subtitle: const Text('Using showDialog()'),
            onTap: () {
              Navigator.pop(context);
              context.push('/dialog-nav');
            },
          ),
          ListTile(
            leading: const Icon(Icons.menu, color: Colors.brown),
            title: const Text('Drawer Navigation'),
            subtitle: const Text('Navigation drawer'),
            onTap: () {
              Navigator.pop(context);
              context.push('/drawer-nav');
            },
          ),
          ListTile(
            leading: const Icon(Icons.route, color: Colors.cyan),
            title: const Text('Named Routes'),
            subtitle: const Text('Using route names'),
            onTap: () {
              Navigator.pop(context);
              context.push('/named-routes');
            },
          ),
          ListTile(
            leading: const Icon(Icons.swap_horiz, color: Colors.orange),
            title: const Text('Push Replacement'),
            subtitle: const Text('context.replace()'),
            onTap: () {
              Navigator.pop(context);
              context.push('/push-replacement');
            },
          ),
          const Divider(),
          
          // Information
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('INFORMATION', style: TextStyle(color: Colors.grey, fontSize: 12)),
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: Colors.grey),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              context.push('/settings');
            },
          ),
          ListTile(
            leading: const Icon(Icons.info, color: Colors.cyan),
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context);
              context.push('/about');
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail, color: Colors.pink),
            title: const Text('Contact'),
            onTap: () {
              Navigator.pop(context);
              context.push('/contact');
            },
          ),
          const Divider(),
          
          // Logout
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              context.go('/login');
            },
          ),
        ],
      ),
    );
  }
}