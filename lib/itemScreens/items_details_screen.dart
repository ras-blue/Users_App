import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/models/items.dart';
// import 'package:users_app/splashScreen/my_splash_screen.dart';
import 'package:users_app/splashScreen/vendor_splash_screen.dart';

// ignore: must_be_immutable
class ItemsDetailsScreen extends StatefulWidget {
  Items? model;

  ItemsDetailsScreen({
    this.model,
  });
  @override
  State<ItemsDetailsScreen> createState() => _ItemsDetailsScreenState();
}

class _ItemsDetailsScreenState extends State<ItemsDetailsScreen> {
  deleteItem() {
    FirebaseFirestore.instance
        .collection("vendor")
        .doc(sharedPreferences!.getString("uid"))
        .collection("brands")
        .doc(widget.model!.brandId)
        .collection('items')
        .doc(widget.model!.itemId)
        .delete()
        .then((value) {
      FirebaseFirestore.instance
          .collection('items')
          .doc(widget.model!.itemId)
          .delete();

      Fluttertoast.showToast(msg: 'Item Deleted Successfully');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (c) => VendorSplashScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.pinkAccent,
                Colors.purpleAccent,
              ],
              begin: FractionalOffset(0.0, 0.0),
              end: FractionalOffset(
                1.0,
                0.0,
              ),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: Text(
          widget.model!.itemTitle.toString(),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          deleteItem();
        },
        label: Text('delete this item'),
        icon: Icon(
          Icons.delete_sweep_outlined,
          color: Colors.white,
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            widget.model!.thumbnailUrl.toString(),
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
          )
        ],
      ),
    );
  }
}
