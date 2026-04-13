import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchScreen extends StatefulWidget {
  final String? initialQuery;
  
  const SearchScreen({super.key, this.initialQuery});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController searchController;
  String searchQuery = '';
  String selectedFilter = 'All';
  bool isSearching = false;
  
  final List<String> filters = ['All', 'Products', 'Categories', 'Brands'];
  
  final List<Map<String, dynamic>> allProducts = [
    {'id': '1', 'name': 'MacBook Pro', 'category': 'Electronics', 'price': 1299, 'type': 'product'},
    {'id': '2', 'name': 'iPhone 15 Pro', 'category': 'Electronics', 'price': 999, 'type': 'product'},
    {'id': '3', 'name': 'Sony Headphones', 'category': 'Audio', 'price': 299, 'type': 'product'},
    {'id': '4', 'name': 'Smart Watch', 'category': 'Wearables', 'price': 399, 'type': 'product'},
    {'id': '5', 'name': 'iPad Air', 'category': 'Electronics', 'price': 599, 'type': 'product'},
    {'id': '6', 'name': 'Gaming Keyboard', 'category': 'Accessories', 'price': 149, 'type': 'product'},
    {'id': '7', 'name': 'Electronics', 'category': 'Category', 'type': 'category'},
    {'id': '8', 'name': 'Audio', 'category': 'Category', 'type': 'category'},
    {'id': '9', 'name': 'Apple', 'category': 'Brand', 'type': 'brand'},
    {'id': '10', 'name': 'Sony', 'category': 'Brand', 'type': 'brand'},
  ];

  List<Map<String, dynamic>> get searchResults {
    if (searchQuery.isEmpty) return [];
    return allProducts.where((item) {
      final matchesQuery = item['name'].toLowerCase().contains(searchQuery.toLowerCase());
      final matchesFilter = selectedFilter == 'All' || 
          (selectedFilter == 'Products' && item['type'] == 'product') ||
          (selectedFilter == 'Categories' && item['type'] == 'category') ||
          (selectedFilter == 'Brands' && item['type'] == 'brand');
      return matchesQuery && matchesFilter;
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    searchQuery = widget.initialQuery ?? '';
    searchController = TextEditingController(text: searchQuery);
    if (searchQuery.isNotEmpty) {
      isSearching = true;
    }
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: Colors.teal,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.canPop() ? context.pop() : context.go('/dashboard'),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Search bar
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: searchController,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Search products, categories...',
                      prefixIcon: const Icon(Icons.search, color: Colors.teal),
                      suffixIcon: searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                setState(() {
                                  searchController.clear();
                                  searchQuery = '';
                                  isSearching = false;
                                });
                              },
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                        isSearching = value.isNotEmpty;
                      });
                    },
                    onSubmitted: (value) {
                      setState(() {
                        searchQuery = value;
                        isSearching = true;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 12),
                // Filter chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: filters.map((filter) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(filter),
                          selected: selectedFilter == filter,
                          onSelected: (selected) {
                            setState(() {
                              selectedFilter = filter;
                            });
                          },
                          backgroundColor: Colors.white.withOpacity(0.2),
                          selectedColor: Colors.white,
                          labelStyle: TextStyle(
                            color: selectedFilter == filter ? Colors.teal : Colors.white,
                            fontWeight: selectedFilter == filter ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
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
        child: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    if (!isSearching) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search, size: 80, color: Colors.white70),
            SizedBox(height: 16),
            Text(
              'Search for products',
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Try "MacBook", "iPhone", or "Headphones"',
              style: TextStyle(color: Colors.white54, fontSize: 14),
            ),
          ],
        ),
      );
    }

    if (searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, size: 80, color: Colors.white70),
            const SizedBox(height: 16),
            Text(
              'No results for "$searchQuery"',
              style: const TextStyle(color: Colors.white70, fontSize: 18),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                setState(() {
                  searchController.clear();
                  searchQuery = '';
                  isSearching = false;
                });
              },
              child: const Text('Clear search', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: searchResults.length,
      itemBuilder: (context, index) {
        final item = searchResults[index];
        return _buildResultCard(context, item);
      },
    );
  }

  Widget _buildResultCard(BuildContext context, Map<String, dynamic> item) {
    IconData icon;
    Color color;
    
    switch (item['type']) {
      case 'product':
        icon = Icons.shopping_bag;
        color = Colors.blue;
        break;
      case 'category':
        icon = Icons.category;
        color = Colors.orange;
        break;
      case 'brand':
        icon = Icons.branding_watermark;
        color = Colors.purple;
        break;
      default:
        icon = Icons.search;
        color = Colors.grey;
    }
    
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(
          item['name'],
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          item['type'] == 'product' 
              ? '\$${item['price']} • ${item['category']}'
              : item['category'],
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          if (item['type'] == 'product') {
            context.push('/product/${item['id']}', extra: item);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Showing ${item['name']} results')),
            );
          }
        },
      ),
    );
  }
}