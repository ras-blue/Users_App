import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/models/address.dart';
import 'package:users_app/splashScreen/vendor_splash_screen.dart';
// import 'package:users_app/splashScreen/my_splash_screen.dart';

// ignore: must_be_immutable
class VendorAddressDesign extends StatelessWidget {
  Address? model;
  String? orderStatus;
  String? orderId;
  String? vendorId;
  String? orderByUser;
  String? totalAmount;

  VendorAddressDesign({
    this.model,
    this.orderStatus,
    this.orderId,
    this.vendorId,
    this.orderByUser,
    this.totalAmount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            "Shipping Details:",
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 6.0,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 90, vertical: 5),
          width: MediaQuery.of(context).size.width,
          child: Table(
            children: [
              // name
              TableRow(
                children: [
                  Text(
                    "Name",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    model!.name.toString(),
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    height: 4,
                  ),
                ],
              ),
              // phone num
              TableRow(
                children: [
                  Text(
                    "Phone Number",
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    model!.phoneNumber.toString(),
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            model!.completeAddress.toString(),
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (orderStatus == "normal") {
              // update earnings
              FirebaseFirestore.instance
                  .collection('vendor')
                  .doc(sharedPreferences!.getString('uid'))
                  .update({
                'earnings': (double.parse(previousEarning)) +
                    (double.parse(totalAmount!)),
              }).whenComplete(() {
                //change order status to shifted
                FirebaseFirestore.instance
                    .collection('orders')
                    .doc(orderId)
                    .update({
                  'status': 'shifted',
                }).whenComplete(() {
                  FirebaseFirestore.instance
                      .collection('users')
                      .doc(orderByUser)
                      .collection('orders')
                      .doc(orderId)
                      .update({
                    'status': 'shifted',
                  }).whenComplete(() {
                    //send notification to user - order shifted
                    Fluttertoast.showToast(msg: 'Confirmed Successfully');

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VendorSplashScreen(),
                      ),
                    );
                  });
                });
              });
            } else if (orderStatus == "shifted") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VendorSplashScreen()));
            } else if (orderStatus == "ended") {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VendorSplashScreen()));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => VendorSplashScreen()));
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              color: Colors.grey,
              width: MediaQuery.of(context).size.width - 40,
              height: orderStatus == "ended"
                  ? 60
                  : MediaQuery.of(context).size.height * .10,
              child: Center(
                child: Text(
                  orderStatus == "ended"
                      ? "Go back"
                      : orderStatus == "shifted"
                          ? "Go back"
                          : orderStatus == "normal"
                              ? "Parcel packed & \nShifted to nearest pickup point. \nClick to Confirm"
                              : "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
