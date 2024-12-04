import 'package:simple_eccomerce/models/ProductModel.dart';

class ResponseModel {
  String? status;
  String? message;
  List<ProductModel>? products; // This should hold the list of products

  ResponseModel({this.status, this.message, this.products});

  ResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];

    if (json['products'] != null) {
      // Parse the products list
      products = <ProductModel>[];
      json['products'].forEach((v) {
        products!.add(ProductModel.fromJson(v)); // Map to ProductModel
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;

    if (products != null) {
      data['products'] = products!
          .map((v) => v.toJson())
          .toList(); // Convert list back to JSON
    }

    return data;
  }
}
