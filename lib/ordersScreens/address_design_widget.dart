import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users_app/models/address.dart';
import 'package:users_app/ratingScreen/rate_seller_screen.dart';
import 'package:users_app/splashScreen/my_splash_screen.dart';

// ignore: must_be_immutable
class AddressDesign extends StatelessWidget {
  Address? model;
  String? orderStatus;
  String? orderId;
  String? vendorId;
  String? orderByUser;

  AddressDesign({
    this.model,
    this.orderStatus,
    this.orderId,
    this.vendorId,
    this.orderByUser,
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MySplashScreen()));
            } else if (orderStatus == "shifted") {
              //  implement Parcel Received feature
              FirebaseFirestore.instance
                  .collection('orders')
                  .doc(orderId)
                  .update({'status': 'ended'}).whenComplete(() {
                FirebaseFirestore.instance
                    .collection('users')
                    .doc(orderByUser)
                    .collection('orders')
                    .doc(orderId)
                    .update({
                  'status': 'ended',
                });

                //send notification to seller

                Fluttertoast.showToast(msg: 'Confirmed Successfully');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MySplashScreen()));
              });
            } else if (orderStatus == "ended") {
              //  implement Rate this vendor feature
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RateSellerScreen(
                    vendorId: vendorId,
                  ),
                ),
              );
            } else {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MySplashScreen()));
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
                      ? "Do you want to Rate this Vendor?"
                      : orderStatus == "shifted"
                          ? "Parcel recieved, \nClick to Confirm"
                          : orderStatus == "normal"
                              ? "Go Back"
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
