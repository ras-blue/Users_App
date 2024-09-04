import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/mainScreens/home_screen.dart';

// ignore: must_be_immutable
class PlaceOrderScreen extends StatefulWidget {
  String? addressID;
  double? totalAmount;
  String? vendorUID;

  PlaceOrderScreen({this.addressID, this.totalAmount, this.vendorUID});

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  String orderId = DateTime.now().millisecondsSinceEpoch.toString();
  orderDetails() {
    saveOrderDetailsForUser({
      "addressID": widget.addressID,
      "totalAmount": widget.totalAmount,
      "orderBy": sharedPreferences!.getString("uid"),
      "productIDs": sharedPreferences!.getStringList("userCart"),
      "paymentDetails": "Cash On Delivery",
      "orderTime": orderId,
      "orderId": orderId,
      "isSuccess": true,
      "status": "normal",
    }).whenComplete(() {
      saveOrderDetailsForVendor({
        "addressID": widget.addressID,
        "totalAmount": widget.totalAmount,
        "orderBy": sharedPreferences!.getString("uid"),
        "productIDs": sharedPreferences!.getStringList("userCart"),
        "paymentDetails": "Cash On Delivery",
        "orderTime": orderId,
        "orderId": orderId,
        "isSuccess": true,
        "status": "normal",
      }).whenComplete(() {
        cartMethods.ClearCart(context);

        // send push notification

        Fluttertoast.showToast(
            msg: "Congratulations, Order has been placed successfully.");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));

        orderId = "";
      });
    });
  }

  saveOrderDetailsForUser(Map<String, dynamic> orderDetailsMap) async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(sharedPreferences!.getString("uid"))
        .collection("orders")
        .doc(orderId)
        .set(orderDetailsMap);
  }

  saveOrderDetailsForVendor(Map<String, dynamic> orderDetailsMap) async {
    await FirebaseFirestore.instance
        .collection("orders")
        .doc(orderId)
        .set(orderDetailsMap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        child: Column(
          children: [
            Image.asset("images/welcome.png"),
            SizedBox(
              height: 12,
            ),
            ElevatedButton(
              onPressed: () {
                orderDetails();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text("Place Order Now"),
            ),
          ],
        ),
      ),
    );
  }
}
