import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ArgumentsScreen extends StatelessWidget {
  const ArgumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arguments Demo with go_router'),
        backgroundColor: Colors.teal,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal.shade700, Colors.teal.shade200],
          ),
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.settings_applications,
                size: 80,
                color: Colors.white,
              ),
              const SizedBox(height: 20),
              const Text(
                'go_router Arguments',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Path Parameters • Query Parameters • Extra Data',
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 40),
              
              // Section 1: Path Parameters
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '📌 Path Parameters (/user/:id)',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildPathParamButton(context, 'User 1', '1'),
                    const SizedBox(height: 8),
                    _buildPathParamButton(context, 'User 2', '2'),
                    const SizedBox(height: 8),
                    _buildPathParamButton(context, 'User 3', '3'),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Section 2: Query Parameters
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '🔍 Query Parameters (?q=search)',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildQueryParamButton(context, 'Search Flutter', 'flutter'),
                    const SizedBox(height: 8),
                    _buildQueryParamButton(context, 'Search Dart', 'dart'),
                    const SizedBox(height: 8),
                    _buildQueryParamButton(context, 'Search GoRouter', 'go_router'),
                  ],
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Section 3: Extra Data (Complex Objects)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '📦 Extra Data (Complex Objects)',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildExtraDataButton(
                      context,
                      'Send Simple String',
                      'Hello from Arguments Screen!',
                    ),
                    const SizedBox(height: 8),
                    _buildExtraDataButton(
                      context,
                      'Send Map with Data',
                      {'name': 'John', 'age': 25, 'course': 'Computer Science'},
                    ),
                    const SizedBox(height: 8),
                    _buildExtraDataButton(
                      context,
                      'Send List',
                      ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 30),
              
              // Code example card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'go_router Route Configuration:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        color: Colors.grey.shade100,
                        child: const Text(
                          '// Path parameter route\n'
                          'GoRoute(\n'
                          '  path: \'/argument-details/:userId\',\n'
                          '  builder: (context, state) {\n'
                          '    final userId = state.pathParameters[\'userId\']!;\n'
                          '    return ArgumentDetailsScreen(userId: userId);\n'
                          '  },\n'
                          '),\n\n'
                          '// Query parameter route\n'
                          'GoRoute(\n'
                          '  path: \'/search\',\n'
                          '  builder: (context, state) {\n'
                          '    final query = state.uri.queryParameters[\'q\'];\n'
                          '    return SearchResultsScreen(query: query);\n'
                          '  },\n'
                          '),\n\n'
                          '// Extra data route\n'
                          'GoRoute(\n'
                          '  path: \'/extra-demo\',\n'
                          '  builder: (context, state) {\n'
                          '    final data = state.extra;\n'
                          '    return ExtraDataScreen(data: data);\n'
                          '  },\n'
                          ')',
                          style: TextStyle(fontFamily: 'monospace', fontSize: 10),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              
              const SizedBox(height: 20),
              
              // Navigation comparison
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '🎯 go_router Navigation Methods:',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• context.go() - Replace stack (no back button)\n'
                      '• context.push() - Add to stack (has back button)\n'
                      '• Path params - For required IDs (/user/:id)\n'
                      '• Query params - For optional filters (?q=search)\n'
                      '• Extra data - For complex objects not in URL',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
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

  Widget _buildPathParamButton(BuildContext context, String label, String userId) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          // Using path parameter - replaces stack
          context.go('/argument-details/$userId');
        },
        icon: const Icon(Icons.person),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.teal,
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  Widget _buildQueryParamButton(BuildContext context, String label, String query) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          // Using query parameter - adds to stack
          context.push('/search-results?q=$query');
        },
        icon: const Icon(Icons.search),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.teal,
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }

  Widget _buildExtraDataButton(BuildContext context, String label, dynamic data) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          // Using extra data for complex objects
          context.push('/extra-demo', extra: {
            'type': label,
            'data': data,
            'timestamp': DateTime.now().toString(),
          });
        },
        icon: const Icon(Icons.send),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.teal,
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}

// Screen that receives data via PATH PARAMETER
class ArgumentDetailsScreen extends StatelessWidget {
  final String userId;

  const ArgumentDetailsScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile: $userId'),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal.shade700, Colors.teal.shade200],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.person, size: 60, color: Colors.teal),
                    const SizedBox(height: 20),
                    Text(
                      'User ID: $userId',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const Text(
                      'How Path Parameters Work:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '1. Route defined as /argument-details/:userId\n'
                      '2. URL contains the actual ID\n'
                      '3. state.pathParameters extracts the value\n'
                      '4. Passed directly to screen constructor',
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () => context.pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                        ),
                        child: const Text('Back'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Screen that receives data via QUERY PARAMETER
class SearchResultsScreen extends StatelessWidget {
  final String? query;

  const SearchResultsScreen({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search: $query'),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal.shade700, Colors.teal.shade200],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.search, size: 60, color: Colors.teal),
                    const SizedBox(height: 20),
                    Text(
                      'Search Results for:',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      '"$query"',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const Text(
                      'How Query Parameters Work:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '1. Navigate with /search-results?q=value\n'
                      '2. state.uri.queryParameters extracts value\n'
                      '3. Great for optional filters and search\n'
                      '4. Preserves browser URL in web apps',
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () => context.pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                        ),
                        child: const Text('Back'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Screen that receives data via EXTRA (complex objects)
class ExtraDataScreen extends StatelessWidget {
  final Map<String, dynamic>? data;

  const ExtraDataScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final type = data?['type'] ?? 'Unknown';
    final receivedData = data?['data'];
    final timestamp = data?['timestamp'] ?? DateTime.now().toString();

    return Scaffold(
      appBar: AppBar(
        title: Text('Extra Data Demo'),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal.shade700, Colors.teal.shade200],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 8,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.data_usage, size: 60, color: Colors.teal),
                    const SizedBox(height: 20),
                    const Text(
                      'Extra Data Received:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Display the data
                    ..._displayReceivedData(receivedData),
                    
                    const SizedBox(height: 16),
                    Text(
                      'Timestamp: $timestamp',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    
                    const SizedBox(height: 20),
                    const Divider(),
                    const Text(
                      'How Extra Data Works:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '1. Pass any object via "extra" parameter\n'
                      '2. state.extra retrieves the data\n'
                      '3. Perfect for complex objects\n'
                      '4. Data not visible in URL (more secure)',
                      style: TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () => context.pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                        ),
                        child: const Text('Back'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _displayReceivedData(dynamic data) {
    if (data is String) {
      return [
        const Text('Data Type: String', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Text(data),
      ];
    } else if (data is Map) {
      List<Widget> widgets = [
        const Text('Data Type: Map', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
      ];
      data.forEach((key, value) {
        widgets.add(Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 60,
                child: Text('$key:', style: const TextStyle(fontWeight: FontWeight.bold)),
              ),
              Expanded(child: Text(value.toString())),
            ],
          ),
        ));
      });
      return widgets;
    } else if (data is List) {
      return [
        const Text('Data Type: List', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        ...data.map((item) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Text('• $item'),
        )),
      ];
    } else {
      return [
        Text('Data: ${data.toString()}'),
      ];
    }
  }
}