import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_eccomerce/models/UserModel.dart';
import 'package:simple_eccomerce/screens/home_screen.dart';
import 'package:simple_eccomerce/screens/login_screen.dart';

class ConfirmationScreen extends StatefulWidget {
  final String total;
  final UserModel user;
  final DateTime date;
  const ConfirmationScreen({
    super.key,
    required this.total,
    required this.user,
    required this.date,
  });

  @override
  State<ConfirmationScreen> createState() => _ConfirmationScreenState();
}

class _ConfirmationScreenState extends State<ConfirmationScreen> {
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
        //widget.user.address = null;
        widget.user.email = null;
        //widget.user.username = null;
        widget.user.password = null;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(8),
          ),
          child: AppBar(
            backgroundColor: Colors.yellow[600],
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Center(
              child: Text(
                'Confirmation Page',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.sizeOf(context).height,
        color: Colors.white,
        child: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your Payment Success',
                style: TextStyle(fontSize: 30, color: Colors.black),
              ),
              SizedBox(height: 30),
              Text(
                'User: ${widget.user.username}',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              SizedBox(height: 5),
              Text(
                'Email: ${widget.user.email}',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              SizedBox(height: 5),
              Text(
                'Phone: ${widget.user.phone}',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              SizedBox(height: 5),
              Text(
                'Date: ${widget.date}',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              SizedBox(height: 5),
              Text(
                'Total: ${widget.total}',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              SizedBox(height: 5),
              Text(
                'Payment Method: Card',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNav(_selectedIndex, _onItemTapped),
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
          Icons.logout,
          color: Colors.grey,
        ),
        label: 'Logout',
      ),
    ],
  );
}
