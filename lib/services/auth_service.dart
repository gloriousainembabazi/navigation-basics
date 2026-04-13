import 'package:flutter/material.dart';

class AuthService extends ChangeNotifier {
  bool _isLoggedIn = false;
  
  bool get isLoggedIn {
    print('🔐 AuthService.isLoggedIn = $_isLoggedIn');
    return _isLoggedIn;
  }
  
  void login() {
    print('🔐 Login() called - setting isLoggedIn to true');
    _isLoggedIn = true;
    notifyListeners();
    print('🔐 notifyListeners() called');
  }
  
  void logout() {
    print('🔐 Logout() called - setting isLoggedIn to false');
    _isLoggedIn = false;
    notifyListeners();
  }
}