import 'package:flutter/cupertino.dart';
import 'package:simple_eccomerce/models/CartModel.dart';
import 'package:simple_eccomerce/models/ProductModel.dart';
import 'package:simple_eccomerce/models/UserModel.dart';

class CartProvider extends ChangeNotifier {
  final List<CartModel> _cart = [];

  List<CartModel> get cart => _cart;

  void addToCart(ProductModel product, int qty, UserModel userData) {
    bool isExist = false;

    for (var cartItem in _cart) {
      if (cartItem.itemName == product.title) {
        cartItem.quantity = (cartItem.quantity ?? 0) + qty; // Update quantity
        isExist = true;
        break;
      }
    }

    if (!isExist) {
      _cart.add(
        CartModel(
          itemName: product.title,
          user: userData,
          price: product.price, // Directly use price as an integer
          imagePath: product.image,
          quantity: qty, // Directly store quantity as an integer
        ),
      );
    }

    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  void removeFromCart(CartModel item) {
    for (var cartItem in _cart) {
      if (cartItem.itemName == item.itemName) {
        if ((cartItem.quantity ?? 0) > 1) {
          cartItem.quantity = (cartItem.quantity ?? 0) - 1; // Decrease quantity
        } else {
          _cart.remove(cartItem); // Remove item if quantity is 1
          break;
        }
        break;
      }
    }
    notifyListeners();
  }
}
