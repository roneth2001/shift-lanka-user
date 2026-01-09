import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shiftlanka_user/models/user_model.dart';
import 'package:shiftlanka_user/screens/auth/auth_service.dart';

/// Authentication Provider for state management
class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  
  UserModel? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _currentUser != null;

  /// Initialize auth state
  Future<void> initializeAuth() async {
    _isLoading = true;
    notifyListeners();

    try {
      User? firebaseUser = _authService.currentUser;
      
      if (firebaseUser != null) {
        // Get user data from Firestore
        Map<String, dynamic>? userData = await _authService.getUserData(firebaseUser.uid);
        
        if (userData != null) {
          _currentUser = UserModel.fromMap(userData, firebaseUser.uid);
        }
      }
    } catch (e) {
      _errorMessage = 'Failed to initialize authentication';
      debugPrint('Initialize auth error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Login
  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      AuthResult result = await _authService.loginWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (result.success && result.userData != null) {
        _currentUser = UserModel.fromMap(result.userData!, result.user!.uid);
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = result.message;
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'An unexpected error occurred';
      _isLoading = false;
      notifyListeners();
      debugPrint('Login error: $e');
      return false;
    }
  }

  /// Logout
  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    try {
      await _authService.logout();
      _currentUser = null;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = 'Logout failed';
      debugPrint('Logout error: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Reset password
  Future<bool> resetPassword(String email) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      AuthResult result = await _authService.resetPassword(email);
      _errorMessage = result.success ? null : result.message;
      _isLoading = false;
      notifyListeners();
      return result.success;
    } catch (e) {
      _errorMessage = 'Failed to send reset email';
      _isLoading = false;
      notifyListeners();
      debugPrint('Reset password error: $e');
      return false;
    }
  }

  /// Update user profile
  Future<bool> updateProfile(Map<String, dynamic> data) async {
    if (_currentUser == null) return false;

    _isLoading = true;
    notifyListeners();

    try {
      bool success = await _authService.updateUserProfile(
        userId: _currentUser!.uid,
        data: data,
      );

      if (success) {
        // Update local user data
        Map<String, dynamic>? updatedData = await _authService.getUserData(_currentUser!.uid);
        if (updatedData != null) {
          _currentUser = UserModel.fromMap(updatedData, _currentUser!.uid);
        }
      }

      _isLoading = false;
      notifyListeners();
      return success;
    } catch (e) {
      _errorMessage = 'Failed to update profile';
      _isLoading = false;
      notifyListeners();
      debugPrint('Update profile error: $e');
      return false;
    }
  }

  /// Refresh user data
  Future<void> refreshUserData() async {
    if (_currentUser == null) return;

    try {
      Map<String, dynamic>? userData = await _authService.getUserData(_currentUser!.uid);
      if (userData != null) {
        _currentUser = UserModel.fromMap(userData, _currentUser!.uid);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Refresh user data error: $e');
    }
  }

  /// Clear error message
  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}