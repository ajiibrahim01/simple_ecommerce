import 'package:simple_eccomerce/models/UserModel.dart';

class CartModel {
  UserModel? user;
  int? price;
  String? imagePath;
  int? quantity;

  CartModel({
    this.user,
    this.price,
    this.imagePath,
    this.quantity,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
    price = json['price'];
    imagePath = json['imagePath'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (user != null) {
      data['user'] = user!.toJson(); // Convert UserModel to JSON
    }
    data['price'] = this.price;
    data['imagePath'] = this.imagePath;
    data['quantity'] = this.quantity;
    return data;
  }
}
