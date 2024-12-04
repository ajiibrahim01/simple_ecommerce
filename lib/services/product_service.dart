import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simple_eccomerce/models/ResponseModel.dart'; // Import the ResponseModel
// Import the ProductModel

class ProductService {
  Future<ResponseModel> getProducts() async {
    try {
      final response =
          await http.get(Uri.parse("https://fakestoreapi.in/api/products"));

      if (response.statusCode == 200) {
        // Decode the response body into a map (not a list)
        final Map<String, dynamic> jsonData = json.decode(response.body);

        // Return ResponseModel which contains the 'status', 'message', and 'products' list
        return ResponseModel.fromJson(jsonData);
      } else {
        throw Exception('Failed to get products');
      }
    } catch (e) {
      throw Exception('Failed to get products: $e');
    }
  }
}
