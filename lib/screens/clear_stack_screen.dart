import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Stack Level 1 Screen
class FirstStackScreen extends StatelessWidget {
  const FirstStackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stack Level 1'),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
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
              'Navigation method: push()',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                context.push('/stack/2');
              },
              child: const Text('Push to Screen 2'),
            ),
            const SizedBox(height: 15),
            OutlinedButton(
              onPressed: () {
                context.replace('/stack/2');
              },
              child: const Text('Replace with Screen 2'),
            ),
          ],
        ),
      ),
    );
  }
}

// Stack Level 2 Screen
class SecondStackScreen extends StatelessWidget {
  const SecondStackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stack Level 2'),
        backgroundColor: Colors.orange,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
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
              'Navigation method: push()',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                context.push('/stack/3');
              },
              child: const Text('Push to Screen 3'),
            ),
            const SizedBox(height: 15),
            OutlinedButton(
              onPressed: () {
                context.pop();
              },
              child: const Text('Pop Back'),
            ),
          ],
        ),
      ),
    );
  }
}

// Stack Level 3 Screen - Demonstrates clearing stack
class ThirdStackScreen extends StatelessWidget {
  const ThirdStackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stack Level 3 - Clear Demo'),
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
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
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Top of Stack',
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 30),
              
              ElevatedButton.icon(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Normal Back (pop to Screen 2)'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
              
              const SizedBox(height: 15),
              
              ElevatedButton.icon(
                onPressed: () {
                  context.go('/dashboard');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Stack cleared! Navigated to Dashboard'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.green,
                    ),
                  );
                },
                icon: const Icon(Icons.clear_all),
                label: const Text('Clear Stack & Go to Dashboard'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
              
              const SizedBox(height: 15),
              
              OutlinedButton.icon(
                onPressed: () {
                  context.go('/');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Stack cleared! Back to Home'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                icon: const Icon(Icons.home),
                label: const Text('Clear Stack & Go to Home'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(color: Colors.white),
                  minimumSize: const Size(double.infinity, 50),
                ),
              ),
              
              const SizedBox(height: 30),
              
              Card(
                color: Colors.white.withOpacity(0.95),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '📊 Stack Management with go_router:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        '• context.go() - Replaces entire stack\n'
                        '• context.push() - Adds to stack\n'
                        '• context.pop() - Removes top of stack\n'
                        '• context.replace() - Replaces current screen',
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
    );
  }
}

// Main ClearStackScreen
class ClearStackScreen extends StatelessWidget {
  const ClearStackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Clear Stack Demo with go_router'),
        backgroundColor: Colors.red,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => context.go('/dashboard'),
          ),
        ],
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
                const Icon(Icons.clear_all, size: 80, color: Colors.white),
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
                  'Using context.go() to replace entire stack',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                const SizedBox(height: 40),
                
                ElevatedButton(
                  onPressed: () {
                    context.push('/stack/1');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.red,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text('Build Navigation Stack'),
                ),
                
                const SizedBox(height: 30),
                
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'go_router Stack Management:',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 12),
                        _buildComparisonTable(),
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

  Widget _buildComparisonTable() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Column(
        children: [
          Row(
            children: [
              Expanded(child: Text('Method', style: TextStyle(fontWeight: FontWeight.bold))),
              Expanded(flex: 2, child: Text('Stack Behavior', style: TextStyle(fontWeight: FontWeight.bold))),
            ],
          ),
          SizedBox(height: 8),
          Row(children: [Expanded(child: Text('push()')), Expanded(flex: 2, child: Text('Adds to stack, back works'))]),
          SizedBox(height: 4),
          Row(children: [Expanded(child: Text('go()')), Expanded(flex: 2, child: Text('Replaces stack, no back'))]),
          SizedBox(height: 4),
          Row(children: [Expanded(child: Text('pop()')), Expanded(flex: 2, child: Text('Removes current screen'))]),
        ],
      ),
    );
  }
}