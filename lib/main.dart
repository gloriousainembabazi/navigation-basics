import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/second_screen.dart';
import 'screens/third_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/about_screen.dart';
import 'screens/contact_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (context) => const HomeScreen(),
        AppRoutes.settings: (context) => const SettingsScreen(),
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.register: (context) => const RegisterScreen(),
        AppRoutes.about: (context) => const AboutScreen(),
        AppRoutes.contact: (context) => const ContactScreen(),
      },
      onGenerateRoute: (settings) {
        final args = settings.arguments as Map<String, dynamic>?;

        if (settings.name == AppRoutes.second) {
          return MaterialPageRoute(
            builder: (context) => SecondScreen(
              studentName: args?['name'] ?? 'Unknown',
              studentCourse: args?['course'] ?? 'Not specified',
              studentYear: args?['year'] ?? 1,
              studentGPA: args?['gpa'] ?? 0.0,
            ),
          );
        }

        if (settings.name == AppRoutes.third) {
          return MaterialPageRoute(
            builder: (context) => ThirdScreen(
              studentName: args?['name'] ?? 'Unknown',
              studentCourse: args?['course'] ?? 'Not specified',
              additionalInfo: args?['info'] ?? 'No additional info',
            ),
          );
        }

        if (settings.name == AppRoutes.details) {
          return MaterialPageRoute(
            builder: (context) => ThirdScreen(
              studentName: args?['name'] ?? 'Unknown',
              studentCourse: args?['course'] ?? 'Not specified',
              additionalInfo: args?['info'] ?? 'No additional info',
            ),
          );
        }

        return null;
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(title: const Text('Error'), backgroundColor: Colors.red),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, size: 60, color: Colors.red),
                const SizedBox(height: 20),
                Text('Route not found: ${settings.name}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => Navigator.pushNamedAndRemoveUntil(context, AppRoutes.home, (route) => false),
                  child: const Text('Go Home'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppRoutes {
  static const String home = '/';
  static const String second = '/second';
  static const String third = '/third';
  static const String details = '/details';
  static const String settings = '/settings';
  static const String login = '/login';
  static const String register = '/register';
  static const String about = '/about';
  static const String contact = '/contact';
}