import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Colors.indigo,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(), // Updated to go_router
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Share feature would open here'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.indigo.shade700, Colors.indigo.shade200],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // App logo
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.school,
                  size: 60,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(height: 20),
              
              // App name
              const Text(
                'Navigation Demo App',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              
              // Version
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Version 1.0.0',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Info cards
              _buildInfoCard(
                '📚 Navigation Concepts (go_router)',
                [
                  '• Declarative routing with GoRouter',
                  '• Path parameters (/user/:id)',
                  '• Query parameters (?q=search)',
                  '• ShellRoute for persistent layouts',
                  '• Route guards with redirect',
                  '• context.go() vs context.push()',
                  '• Deep linking support',
                  '• Nested routes',
                ],
              ),
              
              const SizedBox(height: 15),
              
              _buildInfoCard(
                '🎯 Features',
                [
                  '• Student directory with profiles',
                  '• Login and registration with guards',
                  '• Settings page',
                  '• Contact form',
                  '• About information',
                  '• Responsive design',
                  '• Bottom navigation with ShellRoute',
                ],
              ),
              
              const SizedBox(height: 15),
              
              _buildInfoCard(
                '👨‍💻 Developer',
                [
                  '• Course: Flutter Mobile Development',
                  '• Week 2: go_router & Deep Linking',
                  '• Student: Your Name',
                  '• Year: 2026',
                ],
              ),
              
              const SizedBox(height: 15),
              
              _buildInfoCard(
                '📞 Contact',
                [
                  '• Email: gloriousainembabazi16@gmail.com',
                  '• Phone: +256 750414748',
                  '• Website: www.example.com',
                ],
              ),
              
              const SizedBox(height: 30),
              
              // Navigation buttons with go_router methods
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        context.pop(); // Equivalent to Navigator.pop()
                      },
                      icon: const Icon(Icons.arrow_back),
                      label: const Text('Back'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // context.go() replaces the entire stack (like pushNamedAndRemoveUntil)
                        context.go('/dashboard');
                      },
                      icon: const Icon(Icons.home),
                      label: const Text('Dashboard'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.indigo,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 10),
              
              // Additional go_router demo buttons
              Row(
                children: [
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () {
                        // context.push() adds to stack (back button works)
                        context.push('/contact');
                      },
                      icon: const Icon(Icons.contact_mail, size: 20),
                      label: const Text('Contact (push)'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextButton.icon(
                      onPressed: () {
                        // Navigate with query parameter
                        context.push('/search?q=about');
                      },
                      icon: const Icon(Icons.search, size: 20),
                      label: const Text('Search (query)'),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 20),
              
              // Navigation demo info comparing go_router vs Navigator
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.info, color: Colors.white, size: 20),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'go_router Navigation Methods:',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• context.pop() - Go back\n'
                      '• context.go() - Replace stack (no back)\n'
                      '• context.push() - Add to stack (has back)\n'
                      '• context.replace() - Replace current route\n'
                      '• Deep linking ready with path/query params',
                      style: TextStyle(color: Colors.white70, fontSize: 11),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: const Text(
                        '💡 Tip: Try navigating to /about directly from URL!',
                        style: TextStyle(color: Colors.white, fontSize: 11),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, List<String> items) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 10),
            ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(fontSize: 14)),
                  Expanded(
                    child: Text(
                      item.substring(2), // Remove the bullet point from the string
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}