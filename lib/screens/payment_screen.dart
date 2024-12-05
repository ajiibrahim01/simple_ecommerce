import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:simple_eccomerce/models/UserModel.dart';
import 'package:simple_eccomerce/screens/confirmation_screen.dart';

class PaymentScreen extends StatefulWidget {
  final String totalPayment;
  final UserModel user;

  const PaymentScreen(
      {super.key, required this.totalPayment, required this.user});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isTextVisible = false;

  // Function to toggle the visibility of the text
  void _toggleTextVisibility() {
    setState(() {
      isTextVisible = !isTextVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Payment Screen'),
        backgroundColor: Colors.white,
      ),
      body: Container(
        color: Colors.white,
        margin: EdgeInsets.all(10),
        child: ListView(
          children: [
            Text(
              'Total Payment',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: '\$ ',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: widget.totalPayment.toString(),
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.sizeOf(context).width,
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              height: isTextVisible ? 450 : 70,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: _toggleTextVisibility,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Icon(
                            CupertinoIcons.creditcard,
                            size: 30,
                          ),
                          SizedBox(width: 20),
                          Column(
                            children: [
                              Text(
                                'Card',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                              Row(
                                children: [
                                  SizedBox(width: 10),
                                  Image.asset(
                                    'assets/assets/images/visa_logo_transparent.png',
                                    width: 30,
                                    height: 20,
                                  ),
                                  Image.asset(
                                    'assets/assets/images/mc_logo_transparent.png',
                                    width: 30,
                                    height: 20,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Spacer(),
                          Icon(
                            CupertinoIcons.arrowtriangle_down_fill,
                          )
                        ],
                      ),
                    ),
                  ),
                  Visibility(
                    visible: isTextVisible,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(
                            color: Colors.black,
                            thickness: 1,
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'First Name',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'First Name',
                                        border: OutlineInputBorder(),
                                        filled: true,
                                        fillColor: Colors.grey[100],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Last Name',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Last Name',
                                        border: OutlineInputBorder(),
                                        filled: true,
                                        fillColor: Colors.grey[100],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Card Number',
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Card Number',
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Expired Date',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'MM/YY',
                                        border: OutlineInputBorder(),
                                        filled: true,
                                        fillColor: Colors.grey[100],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 100),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'CVV',
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                    TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'CVV',
                                        border: OutlineInputBorder(),
                                        filled: true,
                                        fillColor: Colors.grey[100],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CupertinoButton(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  color: Colors.black,
                                  child: Row(
                                    children: [
                                      Text(
                                        'Submit',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(width: 5),
                                      Icon(
                                        CupertinoIcons.arrow_right,
                                        color: CupertinoColors.white,
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    print(DateTime.now());
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ConfirmationScreen(
                                                  total: widget.totalPayment
                                                      .toString(),
                                                  user: widget.user,
                                                  date: DateTime.now(),
                                                )));
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
