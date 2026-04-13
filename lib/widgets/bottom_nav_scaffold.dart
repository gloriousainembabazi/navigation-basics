import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavScaffold extends StatefulWidget {
  final Widget child;
  final VoidCallback onLogout;
  
  const BottomNavScaffold({
    super.key,
    required this.child,
    required this.onLogout,
  });

  @override
  State<BottomNavScaffold> createState() => _BottomNavScaffoldState();
}

class _BottomNavScaffoldState extends State<BottomNavScaffold> {
  int _currentIndex = 0;
  
  @override
  void initState() {
    super.initState();
    // Don't access GoRouterState here - wait for didChangeDependencies
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Safe to access GoRouterState here
    _updateCurrentIndex();
  }
  
  @override
  void didUpdateWidget(covariant BottomNavScaffold oldWidget) {
    super.didUpdateWidget(oldWidget);
    _updateCurrentIndex();
  }
  
  void _updateCurrentIndex() {
    // Check if mounted and context is available
    if (!mounted) return;
    
    try {
      final location = GoRouterState.of(context).matchedLocation;
      if (location.startsWith('/dashboard')) {
        _currentIndex = 0;
      } else if (location.startsWith('/products')) {
        _currentIndex = 1;
      } else if (location.startsWith('/explore')) {
        _currentIndex = 2;
      } else if (location.startsWith('/profile')) {
        _currentIndex = 3;
      }
    } catch (e) {
      // Handle error gracefully
      print('Error updating index: $e');
    }
  }
  
  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    
    switch (index) {
      case 0:
        context.go('/dashboard');
        break;
      case 1:
        context.go('/products');
        break;
      case 2:
        context.go('/explore');
        break;
      case 3:
        context.go('/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}