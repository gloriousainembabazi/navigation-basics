import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PassingDataScreen extends StatelessWidget {
  const PassingDataScreen({super.key});

  // Sample products to pass data
  final List<Map<String, dynamic>> products = const [
    {'name': 'Laptop', 'price': 2500000, 'quantity': 5, 'description': 'High-performance laptop'},
    {'name': 'Smartphone', 'price': 1200000, 'quantity': 10, 'description': 'Latest model'},
    {'name': 'Headphones', 'price': 250000, 'quantity': 15, 'description': 'Wireless headphones'},
    {'name': 'Keyboard', 'price': 150000, 'quantity': 8, 'description': 'Mechanical keyboard'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Passing Data Demo with go_router'),
        backgroundColor: Colors.orange,
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
            colors: [Colors.orange.shade700, Colors.orange.shade200],
          ),
        ),
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: const [
                  Icon(Icons.data_usage, size: 50, color: Colors.white),
                  SizedBox(height: 10),
                  Text(
                    'Passing Data via Extra Parameter',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Tap any product to see details',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            
            // Product list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.orange.shade100,
                        child: Icon(Icons.shopping_bag, color: Colors.orange.shade700),
                      ),
                      title: Text(
                        product['name'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('UGX ${product['price']}'),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        // PASSING DATA via extra parameter
                        context.push(
                          '/product-detail',
                          extra: {
                            'name': product['name'],
                            'price': product['price'],
                            'quantity': product['quantity'],
                            'description': product['description'],
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// RECEIVING DATA via extra parameter
class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get data from extra parameter
    final data = GoRouterState.of(context).extra as Map<String, dynamic>?;
    
    final productName = data?['name'] ?? 'Unknown';
    final productPrice = data?['price'] ?? 0;
    final productQuantity = data?['quantity'] ?? 0;
    final productDescription = data?['description'] ?? 'No description';

    return Scaffold(
      appBar: AppBar(
        title: Text(productName),
        backgroundColor: Colors.green,
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
            colors: [Colors.green.shade700, Colors.green.shade200],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle, size: 60, color: Colors.green),
                    const SizedBox(height: 20),
                    
                    // Display received data
                    Text(
                      productName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    
                    _buildDataRow('Price', 'UGX ${productPrice.toString()}'),
                    _buildDataRow('Quantity', productQuantity.toString()),
                    _buildDataRow('Description', productDescription),
                    
                    const SizedBox(height: 30),
                    
                    Text(
                      'Data passed via context.push() extra parameter',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    const SizedBox(height: 20),
                    
                    ElevatedButton(
                      onPressed: () => context.pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: const Text('Back'),
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

  Widget _buildDataRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$label:', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}