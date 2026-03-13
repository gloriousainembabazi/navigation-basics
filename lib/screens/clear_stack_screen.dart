import 'package:flutter/material.dart';

class ClearStackScreen extends StatelessWidget {
  const ClearStackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clear Stack Demo'),
        backgroundColor: Colors.red,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.red.shade700, Colors.red.shade200],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.clear_all,
                  size: 80,
                  color: Colors.white,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Clear Stack Navigation',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Navigator.pushNamedAndRemoveUntil()',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                const SizedBox(height: 40),
                
                // Build stack button
                ElevatedButton(
                  onPressed: () {
                    // Build a stack of screens
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FirstStackScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Build Navigation Stack'),
                ),
                
                const SizedBox(height: 30),
                
                // Explanation card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'pushNamedAndRemoveUntil:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Navigator.pushNamedAndRemoveUntil(\n'
                          '  context,\n'
                          '  \'/home\',\n'
                          '  (route) => false,\n'
                          ');',
                          style: TextStyle(fontFamily: 'monospace', fontSize: 12),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'The predicate (route) => false removes ALL routes\n'
                          'Common uses: Logout, Reset to home, Clear history',
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FirstStackScreen extends StatelessWidget {
  const FirstStackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stack Level 1'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.looks_one, size: 60, color: Colors.blue),
            const SizedBox(height: 20),
            const Text(
              'Screen 1 of 3',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Stack size: 2 (including home)',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SecondStackScreen(),
                  ),
                );
              },
              child: const Text('Go to Screen 2'),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondStackScreen extends StatelessWidget {
  const SecondStackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stack Level 2'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.looks_two, size: 60, color: Colors.orange),
            const SizedBox(height: 20),
            const Text(
              'Screen 2 of 3',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Stack size: 3 (including home)',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ThirdStackScreen(),
                  ),
                );
              },
              child: const Text('Go to Screen 3'),
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdStackScreen extends StatelessWidget {
  const ThirdStackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stack Level 3'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.looks_3, size: 60, color: Colors.red),
              const SizedBox(height: 20),
              const Text(
                'Screen 3 of 3',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                'Stack size: 4 (including home)',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 30),
              
              // Normal back button
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Normal Back (go to Screen 2)'),
              ),
              
              const SizedBox(height: 15),
              
              // Clear stack button - DEMO of pushNamedAndRemoveUntil
              ElevatedButton(
                onPressed: () {
                  // Clear entire stack and go to home
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/', // Home route
                    (route) => false, // Remove all routes
                  );
                  
                  // Show message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Stack cleared! Back to home'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Clear Stack & Go Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}