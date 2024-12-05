import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_eccomerce/models/ProductModel.dart';
import 'package:simple_eccomerce/models/UserModel.dart';
import 'package:simple_eccomerce/screens/detail_screen.dart';
import 'package:simple_eccomerce/services/service_provider.dart';

class SearchScreen extends StatefulWidget {
  final UserModel user;
  const SearchScreen({super.key, required this.user});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<ProductModel> products = [];
  List<ProductModel> _foundedProducts = [];

  @override
  void initState() {
    super.initState();
    // Fetch products from the ServiceProvider when the screen is initialized
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    // Fetch products using the ServiceProvider
    await Provider.of<ServiceProvider>(context, listen: false)
        .getProductsProvider();

    // After fetching, update the list of products
    setState(() {
      products = Provider.of<ServiceProvider>(context, listen: false).products;
      _foundedProducts = products;
    });
  }

  // Method to handle search functionality
  void onSearchProduct(String query) {
    setState(() {
      _foundedProducts = products
          .where((product) =>
              product.title!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search Product',
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Search Product',
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.4),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  prefixIcon: Icon(CupertinoIcons.search),
                  contentPadding: EdgeInsets.fromLTRB(18, 0, 18, 0)),
              onChanged: (value) {
                onSearchProduct(value);
              },
            ),
          ),
          _foundedProducts.isEmpty
              ? Center(
                  child: Text('No products found'),
                )
              : Expanded(
                  child: ListView.builder(
                      itemCount: _foundedProducts.length,
                      itemBuilder: (context, index) {
                        final product = _foundedProducts[index];

                        return ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(
                                    item: product,
                                    user: widget
                                        .user, // Pass product to DetailScreen
                                  ),
                                ));
                          },
                          leading: SizedBox(
                            width: 50,
                            height: 50,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                product.image ??
                                    '', // Use image from the product
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(
                            product.title ?? 'No Title',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          subtitle: Text('\$${product.price ?? 0}'),
                        );
                      }),
                ),
        ],
      ),
    );
  }
}
