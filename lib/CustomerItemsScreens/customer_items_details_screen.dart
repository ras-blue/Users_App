// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cart_stepper/cart_stepper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:users_app/assistantMethods/cart_methods.dart';
import 'package:users_app/global/global.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:users_app/global/global.dart';
import 'package:users_app/models/items.dart';
import 'package:users_app/widgets/appbar_cart_badge.dart';
// import 'package:users_app/splashScreen/my_splash_screen.dart';
// import 'package:users_app/splashScreen/vendor_splash_screen.dart';

// ignore: must_be_immutable
class CustomerItemsDetailsScreen extends StatefulWidget {
  Items? model;

  CustomerItemsDetailsScreen({
    this.model,
  });
  @override
  State<CustomerItemsDetailsScreen> createState() =>
      _CustomerItemsDetailsScreenState();
}

class _CustomerItemsDetailsScreenState
    extends State<CustomerItemsDetailsScreen> {
  int counterLimit = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppbarCartBadge(
        vendorUID: widget.model!.vendorUID.toString(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          int itemCounter = counterLimit;

          List<String> itemsIDsList =
              cartMethods.seperateItemIDsFromUserCartList();

          //1. check if item already exists in cart
          if (itemsIDsList.contains(widget.model!.itemId)) {
            Fluttertoast.showToast(msg: 'Item already in cart');
          } else {
            //2. add item to cart
            cartMethods.addItemToCart(
              widget.model!.itemId.toString(),
              itemCounter,
              context,
            );
          }
        },
        label: Text('Add To Cart'),
        icon: Icon(
          Icons.add_shopping_cart_rounded,
          color: Colors.white,
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              widget.model!.thumbnailUrl.toString(),
            ),
            // implement the item counter

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: CartStepperInt(
                  count: counterLimit,
                  size: 50,
                  // deActiveBackgroundColor: Colors.red,
                  // activeForegroundColor: Colors.white,
                  // activeBackgroundColor: Colors.pinkAccent,
                  didChangeCount: (value) {
                    if (value < 1) {
                      Fluttertoast.showToast(
                          msg: "The quantity cannot be less than 1");
                      return;
                    }
                    setState(() {
                      counterLimit = value;
                    });
                  },
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                top: 5.0,
              ),
              child: Text(
                widget.model!.itemTitle.toString() + ':',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.pinkAccent,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                top: 5.0,
              ),
              child: Text(
                widget.model!.description.toString(),
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(
                10.0,
              ),
              child: Text(
                widget.model!.price.toString(),
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.pink,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8.0, right: 310.0),
              child: Divider(
                height: 1,
                thickness: 2,
                color: Colors.pinkAccent,
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
