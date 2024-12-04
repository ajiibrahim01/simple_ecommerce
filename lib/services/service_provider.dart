import 'dart:async';
import 'package:flutter/material.dart';
import 'package:simple_eccomerce/models/ResponseModel.dart'; // Import ResponseModel
import 'package:simple_eccomerce/models/ProductModel.dart'; // Import ProductModel

import 'package:simple_eccomerce/services/product_service.dart'; // Import ProductService

class ServiceProvider extends ChangeNotifier {
  ServiceProvider();

  final ProductService productService = ProductService();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<ProductModel> _products = []; // List of ProductModel
  List<ProductModel> get products => _products;

  // This method will fetch the products and handle errors
  Future<void> getProductsProvider() async {
    _isLoading = true;
    notifyListeners();

    try {
      // Get the ResponseModel (status, message, and products)
      ResponseModel response = await productService.getProducts();

      if (response.status == "SUCCESS") {
        _products = response.products ?? []; // Extract products list
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
}
