import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BasicNavigationScreen extends StatelessWidget {
  const BasicNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Basic Navigation with go_router'),
        backgroundColor: Colors.blue,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.canPop() ? context.pop() : null,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () => context.go('/dashboard'),
            tooltip: 'Go to Dashboard (Clear Stack)',
          ),
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () => context.push('/about'),
            tooltip: 'About (Push)',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade700, Colors.blue.shade200],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Animated icon
                  TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 500),
                    builder: (context, double value, child) {
                      return Transform.scale(
                        scale: value,
                        child: child,
                      );
                    },
                    child: const Icon(
                      Icons.navigation,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Basic Navigation Demo',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Using context.push() and context.pop()',
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  const SizedBox(height: 40),
                  
                  // Push button (adds to stack)
                  _buildNavigationButton(
                    context: context,
                    label: 'Push New Screen',
                    icon: Icons.add,
                    color: Colors.white,
                    textColor: Colors.blue,
                    onPressed: () => context.push('/second-basic'),
                    description: 'Adds to stack • Back button works',
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Go button (replaces stack)
                  _buildNavigationButton(
                    context: context,
                    label: 'Go (Replace Stack)',
                    icon: Icons.refresh,
                    color: Colors.white,
                    textColor: Colors.blue,
                    onPressed: () => context.go('/second-basic'),
                    description: 'Replaces stack • No back button',
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // PushReplacement button
                  _buildNavigationButton(
                    context: context,
                    label: 'Replace Current Screen',
                    icon: Icons.swap_horiz,
                    color: Colors.orange,
                    textColor: Colors.white,
                    onPressed: () => context.replace('/second-basic'),
                    description: 'Replaces current • Can\'t go back',
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Info card with better design
                  Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          const Text(
                            'go_router Navigation Methods',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildMethodComparison(),
                          const SizedBox(height: 16),
                          const Divider(),
                          const SizedBox(height: 12),
                          _buildBulletPoint(
                            'context.push() - Adds screen to stack (has back button)',
                            Icons.add_circle_outline,
                          ),
                          _buildBulletPoint(
                            'context.go() - Replaces entire stack (no back button)',
                            Icons.refresh,
                          ),
                          _buildBulletPoint(
                            'context.pop() - Removes current screen',
                            Icons.remove_circle_outline,
                          ),
                          _buildBulletPoint(
                            'context.replace() - Replaces top of stack only',
                            Icons.swap_horiz,
                          ),
                          _buildBulletPoint(
                            'context.canPop() - Checks if can navigate back',
                            Icons.check_circle_outline,
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Navigation tips
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.lightbulb, color: Colors.white),
                        SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            '💡 Tip: Use push() for drill-down screens (details), '
                            'use go() for major navigation (tabs, home), '
                            'use replace() for onboarding/wizard flows',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Current route info
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'Current Route: ${GoRouterState.of(context).uri.toString()}',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavigationButton({
    required BuildContext context,
    required String label,
    required IconData icon,
    required Color color,
    required Color textColor,
    required VoidCallback onPressed,
    required String description,
  }) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: onPressed,
            icon: Icon(icon),
            label: Text(label),
            style: ElevatedButton.styleFrom(
              backgroundColor: color,
              foregroundColor: textColor,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          description,
          style: TextStyle(
            fontSize: 11,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildMethodComparison() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          _buildComparisonRow('Method', 'Behavior', isHeader: true),
          const SizedBox(height: 8),
          _buildComparisonRow('push()', 'Adds to stack, back works'),
          const SizedBox(height: 4),
          _buildComparisonRow('go()', 'Replaces stack, no back'),
          const SizedBox(height: 4),
          _buildComparisonRow('pop()', 'Removes current screen'),
          const SizedBox(height: 4),
          _buildComparisonRow('replace()', 'Replaces top of stack'),
        ],
      ),
    );
  }

  Widget _buildComparisonRow(String left, String right, {bool isHeader = false}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            left,
            style: TextStyle(
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
              fontFamily: isHeader ? null : 'monospace',
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Text(
            right,
            style: TextStyle(
              fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBulletPoint(String text, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.blue),
          const SizedBox(width: 8),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

class SecondBasicScreen extends StatelessWidget {
  const SecondBasicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current route information
    final GoRouterState state = GoRouterState.of(context);
    final currentRoute = state.uri.toString();
    final isPush = currentRoute.contains('second-basic') && 
                   !currentRoute.contains('go');
    
    // Get navigation method from route
    String navigationMethod = 'Unknown';
    if (ModalRoute.of(context)?.isCurrent ?? false) {
      navigationMethod = isPush ? 'PUSH' : 'GO/REPLACE';
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
        backgroundColor: Colors.green,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.canPop() ? context.pop() : null,
          tooltip: 'Pop (Go Back)',
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green.shade700, Colors.green.shade200],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.check_circle,
                    size: 80,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'You Navigated to this Screen!',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          navigationMethod == 'PUSH' 
                            ? Icons.add_circle 
                            : Icons.refresh,
                          color: Colors.white,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          navigationMethod == 'PUSH' 
                            ? 'Pushed (has back button)' 
                            : 'Replaced (no back button)',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  
                  // Show current navigation stack info
                  Card(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          const Text(
                            'Current Navigation Info',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Route: $currentRoute',
                            style: const TextStyle(fontSize: 11, fontFamily: 'monospace'),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Method: $navigationMethod',
                            style: TextStyle(
                              fontSize: 12,
                              color: navigationMethod == 'PUSH' 
                                ? Colors.green 
                                : Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  // Pop button
                  ElevatedButton.icon(
                    onPressed: () {
                      if (context.canPop()) {
                        context.pop();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Cannot pop - no previous screen'),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                    },
                    icon: const Icon(Icons.arrow_back),
                    label: const Text('Pop (Go Back)'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      minimumSize: const Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Go to Dashboard button
                  OutlinedButton.icon(
                    onPressed: () {
                      context.go('/dashboard');
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Navigated to Dashboard - Stack cleared'),
                          duration: Duration(seconds: 2),
                          backgroundColor: Colors.blue,
                        ),
                      );
                    },
                    icon: const Icon(Icons.dashboard),
                    label: const Text('Go to Dashboard (Clear Stack)'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Push another screen
                  OutlinedButton.icon(
                    onPressed: () {
                      context.push('/clear-stack');
                    },
                    icon: const Icon(Icons.layers),
                    label: const Text('Push Another Screen'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Stack explanation card
                  Card(
                    color: Colors.white.withOpacity(0.95),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '📚 Understanding Navigation Stack:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            '• push() → Stack grows (can go back)\n'
                            '• go() → Stack replaced (cannot go back)\n'
                            '• pop() → Stack shrinks\n'
                            '• replace() → Current screen replaced',
                            style: TextStyle(fontSize: 12),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              '💡 Notice: The back button behavior changes based on '
                              'how you arrived here!',
                              style: TextStyle(fontSize: 11),
                            ),
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
      ),
    );
  }
}