// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:users_app/CustomerItemsScreens/customer_items_screen.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:users_app/VendorAuthScreens/vendor_auth_screen.dart';
// import 'package:users_app/global/global.dart';
// import 'package:users_app/itemScreens/items_screen.dart';
// import 'package:users_app/mainScreens/vendor_home_screen.dart';
import 'package:users_app/models/brands.dart';
// import 'package:users_app/splashScreen/my_splash_screen.dart';

// ignore: must_be_immutable
class CustomerBrandsUiDesign extends StatefulWidget {
  Brands? model;
  BuildContext? context;

  CustomerBrandsUiDesign({
    this.model,
    this.context,
  });

  @override
  State<CustomerBrandsUiDesign> createState() => _CustomerBrandsUiDesignState();
}

class _CustomerBrandsUiDesignState extends State<CustomerBrandsUiDesign> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => CustomerItemsScreen(
              model: widget.model,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.black,
        elevation: 10,
        shadowColor: Colors.grey,
        child: Padding(
          padding: EdgeInsets.all(4),
          child: SizedBox(
            height: 270,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    widget.model!.thumbnailUrl.toString(),
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 1,
                ),
                Text(
                  widget.model!.brandTitile.toString(),
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
