import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:shiftlanka_user/models/user_model.dart';

/// Profile Service for handling user profile operations
class ProfileService {
  // Singleton pattern
  static final ProfileService _instance = ProfileService._internal();
  factory ProfileService() => _instance;
  ProfileService._internal();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get current user ID
  String? get currentUserId => _auth.currentUser?.uid;

  /// Get user profile data
  Future<ProfileResult> getUserProfile(String userId) async {
    try {
      DocumentSnapshot doc = await _firestore
          .collection('users')
          .doc(userId)
          .get();

      if (!doc.exists) {
        return ProfileResult(
          success: false,
          message: 'User profile not found',
        );
      }

      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      UserModel user = UserModel.fromMap(data, userId);

      return ProfileResult(
        success: true,
        message: 'Profile loaded successfully',
        userData: user,
      );
    } catch (e) {
      debugPrint('Get profile error: $e');
      return ProfileResult(
        success: false,
        message: 'Failed to load profile. Please try again.',
      );
    }
  }

  /// Get user profile stream (real-time updates)
  Stream<DocumentSnapshot> getUserProfileStream(String userId) {
    return _firestore.collection('users').doc(userId).snapshots();
  }

  /// Update user profile
  Future<ProfileResult> updateProfile({
    required String userId,
    String? name,
    String? phoneNumber,
    String? address,
    String? profileImageUrl,
    Map<String, dynamic>? additionalData,
  }) async {
    try {
      Map<String, dynamic> updateData = {};

      if (name != null) updateData['name'] = name;
      if (phoneNumber != null) updateData['phoneNumber'] = phoneNumber;
      if (address != null) updateData['address'] = address;
      if (profileImageUrl != null) updateData['profileImageUrl'] = profileImageUrl;
      
      // Add any additional custom fields
      if (additionalData != null) {
        updateData.addAll(additionalData);
      }

      // Add updated timestamp
      updateData['updatedAt'] = FieldValue.serverTimestamp();

      await _firestore
          .collection('users')
          .doc(userId)
          .update(updateData);

      return ProfileResult(
        success: true,
        message: 'Profile updated successfully',
      );
    } catch (e) {
      debugPrint('Update profile error: $e');
      return ProfileResult(
        success: false,
        message: 'Failed to update profile. Please try again.',
      );
    }
  }

  /// Update specific field
  Future<ProfileResult> updateField({
    required String userId,
    required String fieldName,
    required dynamic value,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .update({
        fieldName: value,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      return ProfileResult(
        success: true,
        message: 'Field updated successfully',
      );
    } catch (e) {
      debugPrint('Update field error: $e');
      return ProfileResult(
        success: false,
        message: 'Failed to update. Please try again.',
      );
    }
  }

  /// Update user preferences
  Future<ProfileResult> updatePreferences({
    required String userId,
    required Map<String, dynamic> preferences,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .update({
        'preferences': preferences,
        'updatedAt': FieldValue.serverTimestamp(),
      });

      return ProfileResult(
        success: true,
        message: 'Preferences updated successfully',
      );
    } catch (e) {
      debugPrint('Update preferences error: $e');
      return ProfileResult(
        success: false,
        message: 'Failed to update preferences. Please try again.',
      );
    }
  }

  /// Deactivate account
  Future<ProfileResult> deactivateAccount(String userId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .update({
        'isActive': false,
        'deactivatedAt': FieldValue.serverTimestamp(),
      });

      return ProfileResult(
        success: true,
        message: 'Account deactivated successfully',
      );
    } catch (e) {
      debugPrint('Deactivate account error: $e');
      return ProfileResult(
        success: false,
        message: 'Failed to deactivate account. Please try again.',
      );
    }
  }

  /// Reactivate account
  Future<ProfileResult> reactivateAccount(String userId) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .update({
        'isActive': true,
        'reactivatedAt': FieldValue.serverTimestamp(),
      });

      return ProfileResult(
        success: true,
        message: 'Account reactivated successfully',
      );
    } catch (e) {
      debugPrint('Reactivate account error: $e');
      return ProfileResult(
        success: false,
        message: 'Failed to reactivate account. Please try again.',
      );
    }
  }

  /// Get user statistics (bookings, trips, etc.)
  Future<Map<String, dynamic>> getUserStatistics(String userId) async {
    try {
      // Example: Get booking count
      QuerySnapshot bookings = await _firestore
          .collection('bookings')
          .where('userId', isEqualTo: userId)
          .get();

      // Example: Get completed trips
      QuerySnapshot completedTrips = await _firestore
          .collection('bookings')
          .where('userId', isEqualTo: userId)
          .where('status', isEqualTo: 'completed')
          .get();

      return {
        'totalBookings': bookings.docs.length,
        'completedTrips': completedTrips.docs.length,
        'memberSince': _auth.currentUser?.metadata.creationTime,
      };
    } catch (e) {
      debugPrint('Get statistics error: $e');
      return {
        'totalBookings': 0,
        'completedTrips': 0,
        'memberSince': DateTime.now(),
      };
    }
  }

  /// Check if phone number is already used
  Future<bool> isPhoneNumberUsed(String phoneNumber, String currentUserId) async {
    try {
      QuerySnapshot query = await _firestore
          .collection('users')
          .where('phoneNumber', isEqualTo: phoneNumber)
          .limit(1)
          .get();

      // If found, check if it's not the current user
      if (query.docs.isNotEmpty) {
        return query.docs.first.id != currentUserId;
      }
      return false;
    } catch (e) {
      debugPrint('Check phone number error: $e');
      return false;
    }
  }

  /// Validate profile data
  ProfileValidation validateProfileData({
    String? name,
    String? phoneNumber,
    String? address,
  }) {
    List<String> errors = [];

    // Validate name
    if (name != null && name.isNotEmpty) {
      if (name.length < 2) {
        errors.add('Name must be at least 2 characters');
      }
      if (name.length > 50) {
        errors.add('Name must be less than 50 characters');
      }
      if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(name)) {
        errors.add('Name can only contain letters and spaces');
      }
    }

    // Validate phone number
    if (phoneNumber != null && phoneNumber.isNotEmpty) {
      // Remove spaces and dashes
      String cleanPhone = phoneNumber.replaceAll(RegExp(r'[\s-]'), '');
      
      // Sri Lankan phone number validation (10 digits starting with 0)
      if (!RegExp(r'^0[0-9]{9}$').hasMatch(cleanPhone)) {
        errors.add('Invalid phone number. Format: 0XXXXXXXXX (10 digits)');
      }
    }

    // Validate address
    if (address != null && address.isNotEmpty) {
      if (address.length < 5) {
        errors.add('Address must be at least 5 characters');
      }
      if (address.length > 200) {
        errors.add('Address must be less than 200 characters');
      }
    }

    return ProfileValidation(
      isValid: errors.isEmpty,
      errors: errors,
    );
  }
}

/// Result class for profile operations
class ProfileResult {
  final bool success;
  final String message;
  final UserModel? userData;

  ProfileResult({
    required this.success,
    required this.message,
    this.userData,
  });
}

/// Validation result class
class ProfileValidation {
  final bool isValid;
  final List<String> errors;

  ProfileValidation({
    required this.isValid,
    required this.errors,
  });

  String get errorMessage => errors.join('\n');
}