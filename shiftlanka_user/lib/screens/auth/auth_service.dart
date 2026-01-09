import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

/// Authentication Service for handling all Firebase Auth operations
class AuthService {
  // Singleton pattern
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Get current user ID
  String? get currentUserId => _auth.currentUser?.uid;

  // Stream of auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  /// Login with email and password
  Future<AuthResult> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      // Sign in with Firebase Auth
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      // Get user data from Firestore
      DocumentSnapshot userDoc = await _firestore
          .collection('passengers')
          .doc(userCredential.user!.uid)
          .get();

      if (!userDoc.exists) {
        // User document doesn't exist in Firestore
        await _auth.signOut();
        return AuthResult(
          success: false,
          message: 'User data not found. Please contact support.',
        );
      }

      Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

      // Check if user is active
      if (userData['isActive'] == false) {
        await _auth.signOut();
        return AuthResult(
          success: false,
          message: 'Your account has been deactivated. Please contact support.',
        );
      }

      // Update last login time
      await _firestore
          .collection('passengers')
          .doc(userCredential.user!.uid)
          .update({
        'lastLoginAt': FieldValue.serverTimestamp(),
      });

      return AuthResult(
        success: true,
        message: 'Login successful',
        user: userCredential.user,
        userData: userData,
      );
    } on FirebaseAuthException catch (e) {
      String message = _getAuthErrorMessage(e.code);
      return AuthResult(
        success: false,
        message: message,
      );
    } catch (e) {
      debugPrint('Login error: $e');
      return AuthResult(
        success: false,
        message: 'An unexpected error occurred. Please try again.',
      );
    }
  }

  /// Get user data from Firestore
  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('passengers')
          .doc(userId)
          .get();

      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      debugPrint('Error getting user data: $e');
      return null;
    }
  }

  /// Get user data stream
  Stream<DocumentSnapshot> getUserDataStream(String userId) {
    return _firestore
        .collection('passengers')
        .doc(userId)
        .snapshots();
  }

  /// Logout
  Future<bool> logout() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      debugPrint('Logout error: $e');
      return false;
    }
  }

  /// Send password reset email
  Future<AuthResult> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      return AuthResult(
        success: true,
        message: 'Password reset email sent. Please check your inbox.',
      );
    } on FirebaseAuthException catch (e) {
      String message = _getAuthErrorMessage(e.code);
      return AuthResult(
        success: false,
        message: message,
      );
    } catch (e) {
      debugPrint('Reset password error: $e');
      return AuthResult(
        success: false,
        message: 'An unexpected error occurred. Please try again.',
      );
    }
  }

  /// Update user profile in Firestore
  Future<bool> updateUserProfile({
    required String userId,
    required Map<String, dynamic> data,
  }) async {
    try {
      await _firestore
          .collection('passengers')
          .doc(userId)
          .update(data);
      return true;
    } catch (e) {
      debugPrint('Update profile error: $e');
      return false;
    }
  }

  /// Change password
  Future<AuthResult> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        return AuthResult(
          success: false,
          message: 'No user logged in',
        );
      }

      // Re-authenticate user
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);

      // Update password
      await user.updatePassword(newPassword);

      return AuthResult(
        success: true,
        message: 'Password changed successfully',
      );
    } on FirebaseAuthException catch (e) {
      String message = _getAuthErrorMessage(e.code);
      return AuthResult(
        success: false,
        message: message,
      );
    } catch (e) {
      debugPrint('Change password error: $e');
      return AuthResult(
        success: false,
        message: 'An unexpected error occurred. Please try again.',
      );
    }
  }

  /// Delete account
  Future<AuthResult> deleteAccount(String password) async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        return AuthResult(
          success: false,
          message: 'No user logged in',
        );
      }

      // Re-authenticate user
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: password,
      );

      await user.reauthenticateWithCredential(credential);

      // Delete user data from Firestore
      await _firestore
          .collection('passengers')
          .doc(user.uid)
          .delete();

      // Delete user account
      await user.delete();

      return AuthResult(
        success: true,
        message: 'Account deleted successfully',
      );
    } on FirebaseAuthException catch (e) {
      String message = _getAuthErrorMessage(e.code);
      return AuthResult(
        success: false,
        message: message,
      );
    } catch (e) {
      debugPrint('Delete account error: $e');
      return AuthResult(
        success: false,
        message: 'An unexpected error occurred. Please try again.',
      );
    }
  }

  /// Send email verification
  Future<AuthResult> sendEmailVerification() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) {
        return AuthResult(
          success: false,
          message: 'No user logged in',
        );
      }

      if (user.emailVerified) {
        return AuthResult(
          success: false,
          message: 'Email is already verified',
        );
      }

      await user.sendEmailVerification();

      return AuthResult(
        success: true,
        message: 'Verification email sent. Please check your inbox.',
      );
    } catch (e) {
      debugPrint('Send verification error: $e');
      return AuthResult(
        success: false,
        message: 'Failed to send verification email. Please try again.',
      );
    }
  }

  /// Reload user to check email verification status
  Future<bool> reloadUser() async {
    try {
      await _auth.currentUser?.reload();
      return _auth.currentUser?.emailVerified ?? false;
    } catch (e) {
      debugPrint('Reload user error: $e');
      return false;
    }
  }

  /// Helper method to get user-friendly error messages
  String _getAuthErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many failed attempts. Please try again later.';
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled.';
      case 'weak-password':
        return 'The password is too weak.';
      case 'invalid-credential':
        return 'Invalid credentials. Please check your email and password.';
      case 'network-request-failed':
        return 'Network error. Please check your connection.';
      case 'requires-recent-login':
        return 'Please log in again to perform this action.';
      default:
        return 'An error occurred. Please try again.';
    }
  }
}

/// Result class for authentication operations
class AuthResult {
  final bool success;
  final String message;
  final User? user;
  final Map<String, dynamic>? userData;

  AuthResult({
    required this.success,
    required this.message,
    this.user,
    this.userData,
  });
}