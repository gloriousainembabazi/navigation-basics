import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Screens
import 'screens/home_screen.dart';
import 'screens/second_screen.dart';
import 'screens/third_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/about_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/basic_navigation_screen.dart';
import 'screens/passing_data_screen.dart';
import 'screens/product_screen.dart';
import 'screens/search_screen.dart';
import 'screens/explore_screen.dart';
import 'screens/arguments_screen.dart';
import 'screens/clear_stack_screen.dart';
import 'screens/dialog_navigation_screen.dart';
import 'screens/drawer_navigation_screen.dart';
import 'screens/named_routes_screen.dart';
import 'screens/push_replacement_screen.dart';
import 'screens/profile_screen.dart';

// Widgets
import 'widgets/bottom_nav_scaffold.dart';

// Services
import 'services/auth_service.dart';

// Route Constants
class AppRoutes {
  static const String home = '/';
  static const String dashboard = '/dashboard';
  static const String second = '/second';
  static const String secondBasic = '/second-basic';  // Added
  static const String third = '/third';
  static const String details = '/details';
  static const String settings = '/settings';
  static const String login = '/login';
  static const String register = '/register';
  static const String about = '/about';
  static const String contact = '/contact';
  static const String basicNavigation = '/basic-navigation';
  static const String passingData = '/passing-data';
  static const String productDetail = '/product/:id';
  static const String products = '/products';
  static const String search = '/search';
  static const String explore = '/explore';
  static const String arguments = '/arguments';
  static const String clearStack = '/clear-stack';
  static const String dialogNav = '/dialog-nav';
  static const String drawerNav = '/drawer-nav';
  static const String namedRoutes = '/named-routes';
  static const String pushReplacement = '/push-replacement';
  static const String profile = '/profile';
  static const String stack1 = '/stack/1';
  static const String stack2 = '/stack/2';
  static const String stack3 = '/stack/3';
}

// Router Configuration
class AppRouter {
  static final AuthService _authService = AuthService();
  
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.login,
    
    // Refresh listenable for reactive auth state changes
    refreshListenable: _authService,
    
    // Route guard - redirect based on authentication
    redirect: (context, state) {
      final loggedIn = _authService.isLoggedIn;
      final goingToLogin = state.matchedLocation == AppRoutes.login;
      final goingToRegister = state.matchedLocation == AppRoutes.register;
      final goingToClearStack = state.matchedLocation == AppRoutes.clearStack;
      final goingToStack = state.matchedLocation.startsWith('/stack');
      final isPublicRoute = goingToLogin || goingToRegister || goingToClearStack || goingToStack;
      
      // Allow access to these routes without auth
      if (isPublicRoute) {
        return null;
      }
      
      // Not logged in and trying to access protected route -> redirect to login
      if (!loggedIn && !isPublicRoute) {
        return AppRoutes.login;
      }
      
      // Already logged in and trying to access login/register -> redirect to dashboard
      if (loggedIn && (goingToLogin || goingToRegister)) {
        return AppRoutes.dashboard;
      }
      
      // No redirect needed
      return null;
    },
    
    // Error handler for unknown routes
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, size: 60, color: Colors.red),
            const SizedBox(height: 20),
            Text(
              'Route not found: ${state.uri.toString()}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_authService.isLoggedIn) {
                  context.go(AppRoutes.dashboard);
                } else {
                  context.go(AppRoutes.login);
                }
              },
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
    
    routes: [
      // Public routes (accessible without authentication)
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => LoginScreen(
          onLogin: () {
            _authService.login();
            // Navigate to dashboard after login
            Future.microtask(() => context.go(AppRoutes.dashboard));
          },
        ),
      ),
      GoRoute(
        path: AppRoutes.register,
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      
      // Clear Stack Demo Routes (public for learning)
      GoRoute(
        path: AppRoutes.clearStack,
        name: 'clearStack',
        builder: (context, state) => const ClearStackScreen(),
      ),
      
      // Stack navigation routes
      GoRoute(
        path: AppRoutes.stack1,
        name: 'stack1',
        builder: (context, state) => const FirstStackScreen(),
      ),
      GoRoute(
        path: AppRoutes.stack2,
        name: 'stack2',
        builder: (context, state) => const SecondStackScreen(),
      ),
      GoRoute(
        path: AppRoutes.stack3,
        name: 'stack3',
        builder: (context, state) => const ThirdStackScreen(),
      ),
      
      // Second Basic route (for HomeScreen navigation)
      GoRoute(
        path: AppRoutes.secondBasic,
        name: 'secondBasic',
        builder: (context, state) => const SecondScreen(),
      ),
      
      // Protected routes with ShellRoute (persistent bottom navigation)
      ShellRoute(
        builder: (context, state, child) {
          return BottomNavScaffold(
            child: child,
            onLogout: () => _authService.logout(),
          );
        },
        routes: [
          // Dashboard (Home)
          GoRoute(
            path: AppRoutes.dashboard,
            name: 'dashboard',
            builder: (context, state) => const HomeScreen(),
            routes: [
              // Nested routes - keep bottom nav visible
              GoRoute(
                path: 'product/:id',
                name: 'dashboardProductDetail',
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  final extra = state.extra as Map<String, dynamic>?;
                  return ProductDetailScreen(
                    productId: id,
                    product: extra,
                  );
                },
              ),
            ],
          ),
          
          // Products tab
          GoRoute(
            path: AppRoutes.products,
            name: 'products',
            builder: (context, state) => const ProductScreen(),
            routes: [
              GoRoute(
                path: ':id',
                name: 'productDetail',
                builder: (context, state) {
                  final id = state.pathParameters['id']!;
                  final extra = state.extra as Map<String, dynamic>?;
                  return ProductDetailScreen(
                    productId: id,
                    product: extra,
                  );
                },
              ),
            ],
          ),
          
          // Explore tab
          GoRoute(
            path: AppRoutes.explore,
            name: 'explore',
            builder: (context, state) => const ExploreScreen(),
          ),
          
          // Profile tab
          GoRoute(
            path: AppRoutes.profile,
            name: 'profile',
            builder: (context, state) {
              final extra = state.extra as Map<String, dynamic>?;
              return ProfileScreen(
                studentName: extra?['name'] ?? 'John Doe',
                studentCourse: extra?['course'] ?? 'Computer Science',
                studentYear: extra?['year'] ?? 3,
                studentGPA: extra?['gpa'] ?? 3.8,
                onLogout: () => _authService.logout(),
              );
            },
          ),
        ],
      ),
      
      // Standalone routes (outside bottom navigation)
      GoRoute(
        path: AppRoutes.second,
        name: 'second',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return SecondScreen(
            studentName: extra?['name'] ?? 'Unknown',
            studentCourse: extra?['course'] ?? 'Not specified',
            studentYear: extra?['year'] ?? 1,
            studentGPA: extra?['gpa'] ?? 0.0,
          );
        },
      ),
      
      GoRoute(
        path: AppRoutes.third,
        name: 'third',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return ThirdScreen(
            studentName: extra?['studentName'] ?? 'Unknown',
            studentCourse: extra?['studentCourse'] ?? 'Not specified',
            additionalInfo: extra?['additionalInfo'] ?? 'No additional info',
          );
        },
      ),
      
      GoRoute(
        path: AppRoutes.details,
        name: 'details',
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return ThirdScreen(
            studentName: extra?['name'] ?? 'Unknown',
            studentCourse: extra?['course'] ?? 'Not specified',
            additionalInfo: extra?['info'] ?? 'No additional info',
          );
        },
      ),
      
      GoRoute(
        path: AppRoutes.settings,
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      
      GoRoute(
        path: AppRoutes.about,
        name: 'about',
        builder: (context, state) => const AboutScreen(),
      ),
      
      GoRoute(
        path: AppRoutes.contact,
        name: 'contact',
        builder: (context, state) => const ContactScreen(),
      ),
      
      // Demo screens
      GoRoute(
        path: AppRoutes.basicNavigation,
        name: 'basicNavigation',
        builder: (context, state) => const Scaffold(
          body: Center(
            child: Text('Basic Navigation Screen Placeholder'),
          ),
        ),
      ),

      GoRoute(
        path: AppRoutes.passingData,
        name: 'passingData',
        builder: (context, state) => const PassingDataScreen(),
      ),
      
      GoRoute(
        path: AppRoutes.search,
        name: 'search',
        builder: (context, state) {
          final query = state.uri.queryParameters['q'];
          return SearchScreen(initialQuery: query);
        },
      ),
      
      GoRoute(
        path: AppRoutes.arguments,
        name: 'arguments',
        builder: (context, state) => const ArgumentsScreen(),
      ),
      
      GoRoute(
        path: AppRoutes.dialogNav,
        name: 'dialogNav',
        builder: (context, state) => const DialogNavigationScreen(),
      ),
      
      GoRoute(
        path: AppRoutes.drawerNav,
        name: 'drawerNav',
        builder: (context, state) => const DrawerNavigationScreen(),
      ),
      
      GoRoute(
        path: AppRoutes.namedRoutes,
        name: 'namedRoutes',
        builder: (context, state) => const NamedRoutesScreen(),
      ),
      
      GoRoute(
        path: AppRoutes.pushReplacement,
        name: 'pushReplacement',
        builder: (context, state) => const PushReplacementScreen(),
      ),
      
      // Home route (redirects based on auth)
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) {
          // Redirect to dashboard if logged in, otherwise login
          if (_authService.isLoggedIn) {
            return const HomeScreen();
          }
          return LoginScreen(onLogin: () => _authService.login());
        },
      ),
    ],
  );
}

// Product Detail Screen (for nested routes)
class ProductDetailScreen extends StatelessWidget {
  final String productId;
  final Map<String, dynamic>? product;
  
  const ProductDetailScreen({
    super.key,
    required this.productId,
    this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product?['name'] ?? 'Product $productId'),
        backgroundColor: Colors.indigo,
        elevation: 0,
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
              Icon(
                Icons.shopping_bag,
                size: 80,
                color: Colors.indigo.shade300,
              ),
              const SizedBox(height: 20),
              Text(
                product?['name'] ?? 'Product Details',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text('Product ID: $productId'),
              const SizedBox(height: 10),
              if (product != null) ...[
                Text('Price: \$${product!['price']}'),
                Text('Category: ${product!['category']}'),
              ],
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => context.pop(),
                child: const Text('Go Back'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}