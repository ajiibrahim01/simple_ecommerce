import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:simple_eccomerce/models/SecondResponseModel.dart';
// Import your UserModel

class UserService {
  // Method to fetch users from the API
  Future<SecondResponseModel> getUsers() async {
    try {
      final response =
          await http.get(Uri.parse("https://fakestoreapi.in/api/users"));

      if (response.statusCode == 200) {
        // Decode the response body into a map (not a list)
        final Map<String, dynamic> jsonData = json.decode(response.body);

        // Return ResponseModel which contains the 'status', 'message', and 'products' list
        return SecondResponseModel.fromJson(jsonData);
      } else {
        throw Exception('Failed to get products');
      }
    } catch (e) {
      throw Exception('Failed to get products: $e');
    }
  }
}
