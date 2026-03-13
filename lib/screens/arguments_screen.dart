import 'package:flutter/material.dart';

class ArgumentsScreen extends StatelessWidget {
  const ArgumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arguments Demo'),
        backgroundColor: Colors.teal,
        elevation: 0,
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
                  'Arguments with Named Routes',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Using onGenerateRoute to handle arguments',
                  style: TextStyle(fontSize: 16, color: Colors.white70),
                ),
                const SizedBox(height: 40),
                
                // Different argument examples
                _buildArgumentButton(
                  context,
                  'Send Simple String',
                  'simple',
                  'Hello from Arguments Screen!',
                ),
                
                const SizedBox(height: 15),
                
                _buildArgumentButton(
                  context,
                  'Send Map with Data',
                  'map',
                  {'name': 'John', 'age': 25, 'course': 'Computer Science'},
                ),
                
                const SizedBox(height: 15),
                
                _buildArgumentButton(
                  context,
                  'Send List',
                  'list',
                  ['Item 1', 'Item 2', 'Item 3', 'Item 4'],
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
                          'onGenerateRoute Example:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.grey.shade100,
                          child: const Text(
                            'onGenerateRoute: (settings) {\n'
                            '  if (settings.name == \'/details\') {\n'
                            '    final args = settings.arguments;\n'
                            '    return MaterialPageRoute(\n'
                            '      builder: (context) => DetailsScreen(\n'
                            '        data: args,\n'
                            '      ),\n'
                            '    );\n'
                            '  }\n'
                            '  return null;\n'
                            '}',
                            style: TextStyle(fontFamily: 'monospace', fontSize: 10),
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
    );
  }

  Widget _buildArgumentButton(BuildContext context, String label, String type, dynamic data) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () {
          // DEMO: pushNamed with arguments
          Navigator.pushNamed(
            context,
            '/argument-details',
            arguments: {
              'type': type,
              'data': data,
              'timestamp': DateTime.now().toString(),
            },
          );
        },
        icon: const Icon(Icons.send),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.teal,
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }
}

// Screen that receives arguments via onGenerateRoute
class ArgumentDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> arguments;

  const ArgumentDetailsScreen({super.key, required this.arguments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Received: ${arguments['type']}'),
        backgroundColor: Colors.teal,
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
                    const Text(
                      'Arguments Received:',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    // Display arguments based on type
                    ..._displayArguments(arguments),
                    
                    const SizedBox(height: 20),
                    
                    const Divider(),
                    
                    const Text(
                      'How it works:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '1. Navigator.pushNamed() with arguments\n'
                      '2. onGenerateRoute catches the route\n'
                      '3. Extracts arguments from settings.arguments\n'
                      '4. Passes arguments to screen constructor',
                      style: TextStyle(fontSize: 12),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    Center(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
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

  List<Widget> _displayArguments(Map<String, dynamic> args) {
    List<Widget> widgets = [];
    args.forEach((key, value) {
      widgets.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 100,
              child: Text('$key:', style: const TextStyle(fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: Text(value.toString()),
            ),
          ],
        ),
      ));
    });
    return widgets;
  }
}