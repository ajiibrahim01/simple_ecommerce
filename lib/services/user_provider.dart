import 'dart:async';
import 'package:flutter/material.dart';
import 'package:simple_eccomerce/models/SecondResponseModel.dart';
import 'package:simple_eccomerce/models/UserModel.dart';

import 'package:simple_eccomerce/services/user_service.dart'; // Import ProductService

class UserProvider extends ChangeNotifier {
  UserProvider();

  final UserService userService = UserService();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<UserModel> _users = []; // List of ProductModel
  List<UserModel> get users => _users;

  // This method will fetch the products and handle errors
  Future<void> getUsersProvider() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Get the ResponseModel (status, message, and products)
      SecondResponseModel response = await userService.getUsers();

      if (response.status == "SUCCESS") {
        _users = response.users ?? []; // Extract products list
      } else {
        _errorMessage = 'Failed to load products: ${response.message}';
      }
    } on TimeoutException {
      _errorMessage = 'Request timed out. Please try again later.';
    } on Exception catch (e) {
      _errorMessage = e.toString();
    } catch (e) {
      _errorMessage = 'Failed to fetch products: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearErrorMessage() {
    _errorMessage = null;
    notifyListeners();
  }

  UserModel? verifyEmailPassword(String email, String password) {
    // Find the user by email
    UserModel? user = _users.firstWhere(
      (user) => user.email == email,
      orElse: () => UserModel(), // Return empty UserModel if not found
    );

    // Check if user is found and the password matches
    if (user.email != null && user.password == password) {
      return user; // Login successful
    } else {
      return null; // Login failed
    }
  }
}
