import 'package:simple_eccomerce/models/UserModel.dart';

class CartModel {
  String? itemName;
  UserModel? user;
  int? price; // Change from String to int
  String? imagePath;
  int? quantity; // Change from String to int

  CartModel({
    this.itemName,
    this.user,
    this.price,
    this.imagePath,
    this.quantity,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    itemName = json['itemName'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    price = json['price']; // Directly parse as an integer
    imagePath = json['imagePath'];
    quantity = json['quantity']; // Directly parse as an integer
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["itemName"] = this.itemName;
    if (user != null) {
      data['user'] = user!.toJson(); // Convert UserModel to JSON
    }
    data['price'] = this.price;
    data['imagePath'] = this.imagePath;
    data['quantity'] = this.quantity;
    return data;
  }
}
