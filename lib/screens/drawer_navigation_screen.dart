import 'package:flutter/material.dart';

class DrawerNavigationScreen extends StatelessWidget {
  const DrawerNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawer Navigation'),
        backgroundColor: Colors.indigo,
        elevation: 0,
      ),
      // The drawer widget
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Drawer Header
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.indigo.shade700, Colors.indigo.shade400],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person, size: 30, color: Colors.indigo),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Ainembabazi Glorious',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  Text(
                    'glorious@gmail.com',
                    style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14),
                  ),
                ],
              ),
            ),
            
            // Drawer Items
            ListTile(
              leading: const Icon(Icons.home, color: Colors.indigo),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context); // Close drawer first
                _showSelectedItem(context, 'Home');
              },
            ),
            
            ListTile(
              leading: const Icon(Icons.shopping_cart, color: Colors.indigo),
              title: const Text('Products'),
              onTap: () {
                Navigator.pop(context);
                _showSelectedItem(context, 'Products');
              },
            ),
            
            ListTile(
              leading: const Icon(Icons.person, color: Colors.indigo),
              title: const Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                _showSelectedItem(context, 'Profile');
              },
            ),
            
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.indigo),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                _showSelectedItem(context, 'Settings');
              },
            ),
            
            const Divider(),
            
            ListTile(
              leading: const Icon(Icons.help, color: Colors.indigo),
              title: const Text('Help'),
              onTap: () {
                Navigator.pop(context);
                _showSelectedItem(context, 'Help');
              },
            ),
            
            ListTile(
              leading: const Icon(Icons.info, color: Colors.indigo),
              title: const Text('About'),
              onTap: () {
                Navigator.pop(context);
                _showSelectedItem(context, 'About');
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
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.indigo.shade700, Colors.indigo.shade200],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.menu,
                size: 80,
                color: Colors.white,
              ),
              const SizedBox(height: 20),
              const Text(
                'Drawer Navigation Demo',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Swipe from left or tap menu icon',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 40),
              
              // Instructions card
              Card(
                margin: const EdgeInsets.all(20),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text(
                        'Drawer Navigation Steps:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      _buildStep('1. Add drawer: property to Scaffold'),
                      _buildStep('2. Create Drawer widget with ListView'),
                      _buildStep('3. Add DrawerHeader for profile section'),
                      _buildStep('4. Add ListTile items with onTap'),
                      _buildStep('5. Always call Navigator.pop() first to close drawer'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep(String step) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          const Icon(Icons.arrow_right, color: Colors.indigo),
          Expanded(child: Text(step, style: const TextStyle(fontSize: 12))),
        ],
      ),
    );
  }

  void _showSelectedItem(BuildContext context, String item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Selected: $item'),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
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
              Navigator.pop(context); // Go back to previous screen
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