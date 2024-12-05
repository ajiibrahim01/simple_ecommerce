import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_eccomerce/models/ProductModel.dart';
import 'package:simple_eccomerce/models/UserModel.dart';
import 'package:simple_eccomerce/screens/cart_screen.dart';
import 'package:simple_eccomerce/screens/detail_screen.dart';
import 'package:simple_eccomerce/screens/search_screen.dart';
import 'package:simple_eccomerce/services/cart_provider.dart';
import 'package:simple_eccomerce/services/service_provider.dart'; // Import ServiceProvider

class HomeScreen extends StatefulWidget {
  final UserModel user;
  const HomeScreen({super.key, required this.user});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        toolbarHeight: 170,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Welcome ',
                ),
                Text(
                  '${widget.user.username}',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                )
              ],
            ),
            Text('to Fantasy Shop'),
            SizedBox(height: 10),
            Container(
              child: IconButton(
                  icon: Icon(
                    CupertinoIcons.search,
                    size: 20,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SearchScreen()));
                  }),
            ),
            SizedBox(width: 100),
          ],
        ),
        actions: [
          Consumer<CartProvider>(
            builder: (context, value, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        IconButton(
                          icon: Icon(
                            CupertinoIcons.bag,
                            size: 30,
                          ),
                          onPressed: () {
                            goToCart();
                          },
                        ),
                        SizedBox(height: 10),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            CupertinoIcons.heart_fill,
                            color: Colors.redAccent,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.filter_list),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 14,
                      left: 14,
                      child: Visibility(
                        visible: value.cart.isNotEmpty ? true : false,
                        child: CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.transparent,
                          child: Center(
                            child: Text(
                              value.cart.length.toString(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ],
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
          // Display products in a GridView
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 1,
                mainAxisSpacing: 1,
                childAspectRatio: 2 / 3),
            itemCount: value.products.length,
            itemBuilder: (context, index) {
              final product = value.products[index];
              //bool isFavorited = favoriteStatus[product.id] ?? false;

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
                                            ? CupertinoIcons.heart_fill
                                            : CupertinoIcons.heart,
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
