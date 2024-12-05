import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_eccomerce/models/ProductModel.dart';
import 'package:simple_eccomerce/models/UserModel.dart';
import 'package:simple_eccomerce/screens/cart_screen.dart';
import 'package:simple_eccomerce/screens/detail_screen.dart';
import 'package:simple_eccomerce/services/service_provider.dart'; // Import ServiceProvider

class FavoriteScreen extends StatefulWidget {
  final Map<String, bool> favorite;
  final UserModel user;
  const FavoriteScreen({super.key, required this.user, required this.favorite});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch the products when the screen is initialized
    Provider.of<ServiceProvider>(context, listen: false).getProductsProvider();
  }

  void goToDetail(ProductModel product, UserModel userData) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailScreen(
          item: product,
          user: userData,
        ),
      ),
    );
  }

  Map<String, bool> favoriteStatus = {};

  void goToCart() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(
          user: widget.user,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${widget.user.username}'s",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                Text("favorite products"),
              ],
            ),
          ],
        ),
      ),
      body: Container(color: Colors.white, child: GetProductList()),
    );
  }

  Consumer<ServiceProvider> GetProductList() {
    return Consumer<ServiceProvider>(
      builder: (context, value, child) {
        if (value.isLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (value.errorMessage != null) {
          return Center(
            child: Text(value.errorMessage!),
          );
        } else {
          final favoriteProducts = value.products.where((product) {
            return widget.favorite[product.id.toString()] == true;
          }).toList();
          // Display products in a GridView
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                childAspectRatio: 2 / 3),
            itemCount: favoriteProducts.length,
            itemBuilder: (context, index) {
              final product = value.products[index];

              bool hasDiscount =
                  product.discount != null && product.discount! > 0;
              int finalPrice = 0;
              if (hasDiscount) {
                int newPrice = ((product.price ?? 0) -
                        ((product.price ?? 0) *
                            (int.parse(product.discount.toString()) / 100)))
                    .round();

                finalPrice = newPrice;
              }
              return GestureDetector(
                onTap: () {
                  if (finalPrice > 0) {
                    product.price = finalPrice;
                  }
                  goToDetail(product, widget.user);
                },
                child: Padding(
                  padding: const EdgeInsets.all(5),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        width: 2,
                        color: Colors.black,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SizedBox(
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height,
                        child: Container(
                          color: Colors.grey.shade50,
                          //padding: EdgeInsets.all(15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    width: MediaQuery.sizeOf(context).width,
                                    color: Colors.white,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 45),
                                      child: SizedBox(
                                        height: 162,
                                        width: MediaQuery.sizeOf(context).width,
                                        child: Image.network(
                                          product.image ?? '',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: IconButton(
                                      icon: Icon(
                                        favoriteStatus[product.id.toString()] ==
                                                true
                                            ? CupertinoIcons.heart
                                            : CupertinoIcons.heart_fill,
                                        color: Colors.red,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        // Action for the button
                                        setState(() {
                                          favoriteStatus[product.id
                                              .toString()] = !(favoriteStatus[
                                                  product.id.toString()] ??
                                              false);
                                        });
                                        print(product.id);
                                      },
                                    ),
                                  ),
                                  Positioned(
                                    top: 10,
                                    left: 8,
                                    child: Row(
                                      children: [
                                        if (hasDiscount) ...[
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Icon(
                                                Icons.local_offer,
                                                size: 20,
                                                color: Colors.red,
                                              ),
                                              Text(
                                                ' ${product.discount ?? 0}%',
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  product.title ?? 'No Title',
                                  style: TextStyle(
                                    fontSize: 12,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    if (hasDiscount) ...[
                                      Text(
                                        '\$${product.price ?? 0}',
                                        style: TextStyle(
                                          color: Colors.green,
                                          decoration:
                                              TextDecoration.lineThrough,
                                          decorationColor: Colors.black,
                                          decorationThickness: 1,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        '\$${finalPrice ?? 0}',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ] else ...[
                                      Text(
                                        '\$${product.price ?? 0}',
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
