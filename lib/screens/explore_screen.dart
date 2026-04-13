import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  final List<Map<String, dynamic>> categories = const [
    {
      'name': 'Electronics',
      'icon': Icons.devices,
      'color': Colors.blue,
      'count': 245,
      'products': ['Smartphones', 'Laptops', 'Tablets', 'Accessories'],
    },
    {
      'name': 'Fashion',
      'icon': Icons.checkroom,
      'color': Colors.pink,
      'count': 189,
      'products': ['Clothing', 'Shoes', 'Bags', 'Watches'],
    },
    {
      'name': 'Home & Living',
      'icon': Icons.home,
      'color': Colors.green,
      'count': 156,
      'products': ['Furniture', 'Decor', 'Kitchen', 'Bedding'],
    },
    {
      'name': 'Sports',
      'icon': Icons.sports_soccer,
      'color': Colors.orange,
      'count': 98,
      'products': ['Equipment', 'Apparel', 'Fitness', 'Outdoor'],
    },
    {
      'name': 'Books',
      'icon': Icons.menu_book,
      'color': Colors.purple,
      'count': 312,
      'products': ['Fiction', 'Non-Fiction', 'Textbooks', 'Magazines'],
    },
    {
      'name': 'Toys',
      'icon': Icons.toys,
      'color': Colors.red,
      'count': 134,
      'products': ['Games', 'Puzzles', 'Action Figures', 'Educational'],
    },
  ];

  final List<Map<String, dynamic>> trendingProducts = const [
    {'name': 'iPhone 15 Pro', 'price': 999, 'reviews': 1892, 'rating': 4.9},
    {'name': 'MacBook Pro M3', 'price': 1599, 'reviews': 543, 'rating': 4.8},
    {'name': 'Sony WH-1000XM5', 'price': 399, 'reviews': 2876, 'rating': 4.7},
    {'name': 'Apple Watch Ultra', 'price': 799, 'reviews': 987, 'rating': 4.8},
  ];

  final List<Map<String, dynamic>> featuredCollections = const [
    {'name': 'Summer Sale', 'image': '🔥', 'discount': 'Up to 50% off'},
    {'name': 'New Arrivals', 'image': '✨', 'discount': 'Just landed'},
    {'name': 'Best Sellers', 'image': '🏆', 'discount': 'Customer favorites'},
    {'name': 'Clearance', 'image': '💎', 'discount': 'Limited time'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Explore'),
        backgroundColor: Colors.deepOrange,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.canPop() ? context.pop() : context.go('/dashboard'),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => context.push('/search'),
            tooltip: 'Search',
          ),
          IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Notifications coming soon')),
              );
            },
            tooltip: 'Notifications',
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepOrange.shade700, Colors.deepOrange.shade200],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            // Hero banner
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(16),
                height: 180,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Colors.amber, Colors.deepOrange],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: 20,
                      top: 20,
                      child: const Text(
                        '🎉',
                        style: TextStyle(fontSize: 80),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Weekend Special!',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Extra 20% off on selected items',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context.push('/products');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.deepOrange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text('Shop Now →'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Featured Collections
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Featured Collections',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: featuredCollections.length,
                  itemBuilder: (context, index) {
                    final collection = featuredCollections[index];
                    return Container(
                      width: 160,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            collection['image'],
                            style: const TextStyle(fontSize: 40),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            collection['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            collection['discount'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
            
            // Categories Grid
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Shop by Category',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final category = categories[index];
                    return _buildCategoryCard(context, category);
                  },
                  childCount: categories.length,
                ),
              ),
            ),
            
            // Trending Products
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Trending Now',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final product = trendingProducts[index];
                    return _buildTrendingCard(context, product);
                  },
                  childCount: trendingProducts.length,
                ),
              ),
            ),
            
            const SliverToBoxAdapter(
              child: SizedBox(height: 80),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, Map<String, dynamic> category) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: () {
          // Navigate to category products with query parameter
          context.push('/search?q=${category['name']}');
        },
        borderRadius: BorderRadius.circular(16),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                category['color'].withOpacity(0.1),
                category['color'].withOpacity(0.3),
              ],
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                category['icon'],
                size: 48,
                color: category['color'],
              ),
              const SizedBox(height: 12),
              Text(
                category['name'],
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: category['color'],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '${category['count']} products',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrendingCard(BuildContext context, Map<String, dynamic> product) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.deepOrange.shade100,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.trending_up, color: Colors.deepOrange),
        ),
        title: Text(
          product['name'],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Row(
          children: [
            const Icon(Icons.star, size: 14, color: Colors.amber),
            const SizedBox(width: 4),
            Text('${product['rating']}'),
            const SizedBox(width: 8),
            Text('(${product['reviews']} reviews)'),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '\$${product['price']}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.deepOrange,
              ),
            ),
          ],
        ),
        onTap: () {
          context.push('/product/trending', extra: product);
        },
      ),
    );
  }
}