import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_eccomerce/models/ProductModel.dart';
import 'package:simple_eccomerce/models/UserModel.dart';
import 'package:simple_eccomerce/screens/home_screen.dart';
import 'package:simple_eccomerce/screens/login_screen.dart';

class DetailScreen extends StatefulWidget {
  final ProductModel item;
  final UserModel user;
  const DetailScreen({super.key, required this.item, required this.user});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    int qtyCount = 0;
    int totalPrice = 0;

    void incrementQty() {
      setState(() {
        qtyCount++;
        totalPrice = qtyCount * int.parse(widget.item.price.toString());
      });
    }

    void decrementQty() {
      setState(() {
        if (qtyCount > 0) {
          qtyCount--;
          totalPrice = qtyCount * int.parse(widget.item.price.toString());
        }
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
          Navigator.pop(context);
          break;
        case 1:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
          break;
      }
    }

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
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        color: Colors.white,
        child: DetailProduct(),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
      ),
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
            ],
          ),
        ),
      ),
    );
  }
}
