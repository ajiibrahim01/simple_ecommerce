import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_eccomerce/models/CartModel.dart';
import 'package:simple_eccomerce/models/ProductModel.dart';
import 'package:simple_eccomerce/models/UserModel.dart';
import 'package:simple_eccomerce/screens/cart_screen.dart';
import 'package:simple_eccomerce/screens/home_screen.dart';
import 'package:simple_eccomerce/services/cart_provider.dart';

class DetailScreen extends StatefulWidget {
  final ProductModel item;
  final UserModel user;
  const DetailScreen({super.key, required this.item, required this.user});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int qtyCount = 0;
  int totalPrice = 0;

  void incrementQty() {
    setState(() {
      qtyCount++;
      totalPrice = qtyCount * (widget.item.price ?? 0);
    });
  }

  void decrementQty() {
    setState(() {
      if (qtyCount > 0) {
        qtyCount--;
        totalPrice = qtyCount * (widget.item.price ?? 0);
      }
    });
  }

  void addToCart() {
    if (qtyCount > 0) {
      final cart = context.read<CartProvider>();
      cart.addToCart(widget.item, qtyCount, widget.user);
      popUpDialog(); // Show modal bottom sheet after adding to cart
    }
  }

  void popUpDialog() {
    setState(() {
      qtyCount = 0;
      totalPrice = 0;
    });
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index when tapped
    });

    // Navigate to the corresponding page based on the tapped index
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              user: widget.user,
            ),
          ),
        );
        break;
      case 1:
        addToCart();
        break;
    }
  }

  void goToCart(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(user: widget.user),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Detail Screen',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          Consumer<CartProvider>(
            builder: (context, value, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: Icon(CupertinoIcons.bag, size: 30, color: Colors.black
                        // Increased icon size for better visibility
                        ),
                    onPressed: () {
                      goToCart(context); // Pass context to navigate
                    },
                  ),
                  Positioned(
                    top: 14,
                    left: 14,
                    child: Visibility(
                      visible: value.cart.isNotEmpty,
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
                  ),
                ],
              );
            },
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        color: Colors.white,
        child: DetailProduct(),
      ),
      bottomNavigationBar: BottomNav(_selectedIndex, _onItemTapped),
    );
  }

  SingleChildScrollView DetailProduct() {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.item.title.toString(),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Image.network(
                widget.item.image.toString(),
                fit: BoxFit.cover,
                width: 200,
                height: 200,
              ),
              SizedBox(height: 10),
              Text(
                'Description',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 5),
              Text(widget.item.description.toString()),
              SizedBox(height: 10),
              Text(
                'Model',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 5),
              Text(widget.item.model.toString()),
              SizedBox(height: 10),
              Text(
                'Brand',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 5),
              Text(widget.item.brand.toString()),
              SizedBox(height: 10),
              Text(
                'Price',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 5),
              Text('\$ ${widget.item.price.toString()}'),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      decrementQty();
                    },
                    icon: Icon(
                      CupertinoIcons.minus,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 20),
                  // Text
                  Text(
                    qtyCount.toString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 20),
                  IconButton(
                    onPressed: () {
                      incrementQty();
                    },
                    icon: Icon(
                      CupertinoIcons.plus,
                      size: 30,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

BottomNavigationBar BottomNav(
    int _selectedIndex, void _onItemTapped(int index)) {
  return BottomNavigationBar(
    backgroundColor:
        Colors.white, // Set the background color of the BottomNavigationBar
    currentIndex: _selectedIndex, // Set the current selected index
    onTap: _onItemTapped, // Call the method when an item is tapped
    items: const [
      BottomNavigationBarItem(
        icon: Icon(
          CupertinoIcons.home,
          color: Colors.grey,
        ),
        label: 'Home',
      ),
      BottomNavigationBarItem(
        icon: Icon(
          CupertinoIcons.shopping_cart,
          color: Colors.grey,
        ),
        label: 'Cart',
      ),
    ],
  );
}
