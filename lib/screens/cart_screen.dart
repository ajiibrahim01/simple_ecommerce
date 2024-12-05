import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_eccomerce/models/UserModel.dart';
import 'package:simple_eccomerce/screens/home_screen.dart';
import 'package:simple_eccomerce/screens/payment_screen.dart';
import 'package:simple_eccomerce/services/cart_provider.dart';

class CartScreen extends StatefulWidget {
  final UserModel user;
  const CartScreen({super.key, required this.user});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool loader = true;

  @override
  void initState() {
    Future.delayed(Duration(seconds: 1)).then((value) {
      setState(() {
        loader = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int parsePrice(String price) {
      // Remove any non-numeric characters (like "Rp." or commas)
      String sanitizedPrice = price.replaceAll(RegExp(r'[^0-9]'), '');

      // Return the parsed integer value
      return int.parse(sanitizedPrice); // Default to 0 if parsing fails
    }

    return Consumer<CartProvider>(
      builder: (context, value, child) {
        int price = 0;
        int totalPrice = 0;
        int taxAndService = 2;
        int totalPayment = 0;

        // Calculate total price for cart items
        for (var cartModel in value.cart) {
          price = int.parse(cartModel.quantity.toString()) *
              parsePrice(cartModel.price.toString());
          totalPrice += price;
        }

        // Calculate tax and service fee
        //taxAndService = (totalPrice * 0.11).toInt();
        totalPayment = (totalPrice + taxAndService);

        return loader
            ? Center(
                child: SizedBox(
                  child: CircularProgressIndicator(),
                ),
              )
            : Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  title: Text('Cart'),
                  backgroundColor: Colors.white,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: Row(
                          children: [
                            Text('Clear cart'),
                            SizedBox(width: 10),
                            Icon(CupertinoIcons.trash_circle),
                          ],
                        ),
                        onPressed: () {
                          Provider.of<CartProvider>(context, listen: false)
                              .clearCart();
                          setState(() {
                            price = 0;
                            totalPrice = 0;
                            taxAndService = 0;
                            totalPayment = 0;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                body: value.cart.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Your cart is empty.',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 10),
                            CupertinoButton(
                              color: Theme.of(context).primaryColor,
                              child: Text('Add Some Product'),
                              onPressed: () {
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          HomeScreen(user: widget.user)),
                                  (route) => false,
                                );
                              },
                            )
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: value.cart.length,
                        itemBuilder: (context, index) {
                          final item = value.cart[index];
                          return ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Container(
                                width: 50,
                                height: 50,
                                child: Image.network(
                                  item.imagePath.toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Text(item.itemName
                                .toString()), // Corrected to itemName
                            subtitle: Row(
                              children: [
                                Text(
                                  '\$ ${item.price} x ${item.quantity}',
                                ),
                              ],
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  value?.removeFromCart(item);
                                  if (value.cart.isEmpty) {
                                    price = 0;
                                    totalPrice = 0;
                                    taxAndService = 0;
                                    totalPayment = 0;
                                  }
                                },
                                icon: Icon(CupertinoIcons.minus)),
                          );
                        }),
                bottomNavigationBar: totalPrice == 0
                    ? null
                    : Container(
                        //color: Theme.of(context).scaffoldBackgroundColor,
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              padding: EdgeInsets.all(16),
                              margin: EdgeInsets.all(16),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Price'),
                                      Text('\$ ${totalPrice}'),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Service Fee'),
                                      Text('\$ ${taxAndService}'),
                                    ],
                                  ),
                                  Divider(),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Total Payment'),
                                      Text('\$ ${totalPayment}'),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                              width: MediaQuery.of(context).size.width,
                              child: CupertinoButton(
                                color: Theme.of(context).primaryColor,
                                child: Row(
                                  children: [
                                    Text('Pay Now'),
                                    SizedBox(width: 10),
                                    Icon(CupertinoIcons.arrow_right),
                                  ],
                                ),
                                onPressed: () {
                                  Provider.of<CartProvider>(context,
                                          listen: false)
                                      .clearCart();

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PaymentScreen(
                                              totalPayment:
                                                  totalPayment.toString(),
                                              user: widget.user)));
                                },
                              ),
                            )
                          ],
                        ),
                      ),
              );
      },
    );
  }
}
