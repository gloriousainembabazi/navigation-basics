import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Route constants (best practice from notes)
class NamedRoutes {
  static const String home = '/named-home';
  static const String products = '/named-products';
  static const String details = '/named-details';
  static const String profile = '/named-profile';
}

class NamedRoutesScreen extends StatelessWidget {
  const NamedRoutesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Named Routes Demo with go_router'),
        backgroundColor: Colors.purple,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.canPop() ? context.pop() : context.go('/dashboard'),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple.shade700, Colors.purple.shade200],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.route,
                  size: 80,
                  color: Colors.white,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Named Routes with go_router',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Using route names with context.pushNamed()',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                const SizedBox(height: 40),
                
                // Demo buttons using named routes
                _buildNamedRouteButton(
                  context,
                  'Go to Products',
                  NamedRoutes.products,
                  Icons.shopping_bag,
                ),
                
                const SizedBox(height: 15),
                
                _buildNamedRouteButton(
                  context,
                  'Go to Profile',
                  NamedRoutes.profile,
                  Icons.person,
                ),
                
                const SizedBox(height: 30),
                
                // Info card
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Text(
                          'go_router Named Routes:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        _buildRouteCode('GoRoute('),
                        _buildRouteCode('  name: \'products\','),
                        _buildRouteCode('  path: \'/named-products\','),
                        _buildRouteCode('  builder: (context, state) => NamedProductsScreen(),'),
                        _buildRouteCode('),'),
                        const SizedBox(height: 8),
                        const Text(
                          'Usage:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        _buildRouteCode('context.pushNamed(\'products\');'),
                        _buildRouteCode('// or'),
                        _buildRouteCode('context.push(NamedRoutes.products);'),
                      ],
                    ),
                  ),
                ),
                
                const SizedBox(height: 20),
                
                // Current route info
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
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
    );
  }

  Widget _buildNamedRouteButton(BuildContext context, String label, String route, IconData icon) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          // DEMO: context.pushNamed() with go_router
          context.pushNamed(route.split('/').last);
        },
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.purple,
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildRouteCode(String code) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        code,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 12,
        ),
      ),
    );
  }
}

// Products screen (reached via named route)
class NamedProductsScreen extends StatelessWidget {
  const NamedProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        backgroundColor: Colors.purple,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text('Product ${index + 1}'),
              subtitle: Text('UGX ${(index + 1) * 100000}'),
              onTap: () {
                // Navigate to details with extra data
                context.push(
                  NamedRoutes.details,
                  extra: {
                    'id': index + 1,
                    'name': 'Product ${index + 1}',
                    'price': (index + 1) * 100000,
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}