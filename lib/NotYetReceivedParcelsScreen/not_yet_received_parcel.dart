import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:users_app/VendorOrderScreens/vendor_order_card.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/ordersScreens/order_card.dart';

class NotYetReceivedParcel extends StatefulWidget {
  const NotYetReceivedParcel({super.key});

  @override
  State<NotYetReceivedParcel> createState() => _NotYetReceivedParcelState();
}

class _NotYetReceivedParcelState extends State<NotYetReceivedParcel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
          'Not Yet Received Parcels',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("orders")
            .where("status", isEqualTo: "shifted")
            .where('orderBy', isEqualTo: sharedPreferences!.getString('uid'))
            .orderBy("orderTime", descending: true)
            .snapshots(),
        builder: (c, AsyncSnapshot dataSnapShot) {
          if (dataSnapShot.hasData) {
            return ListView.builder(
              itemCount: dataSnapShot.data.docs.length,
              itemBuilder: (c, index) {
                return FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("items")
                      .where("itemId",
                          whereIn: cartMethods.seperateOrderItemIDs(
                              (dataSnapShot.data.docs[index].data()
                                  as Map<String, dynamic>)["productIDs"]))
                      .where("orderBy",
                          whereIn: (dataSnapShot.data.docs[index].data()
                              as Map<String, dynamic>)["uid"])
                      .orderBy("publishedDate", descending: true)
                      .get(),
                  builder: (c, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return OrderCard(
                        itemCount: snapshot.data.docs.length,
                        data: snapshot.data.docs,
                        orderId: dataSnapShot.data.docs[index].id,
                        seperateQuantitiesList:
                            cartMethods.seperateOrderItemsQuantities(
                                (dataSnapShot.data.docs[index].data()
                                    as Map<String, dynamic>)['productIDs']),
                      );
                    } else {
                      return Center(
                        child: Text(
                          "No data exists.",
                        ),
                      );
                    }
                  },
                );
              },
            );
          } else {
            return Center(
              child: Text(
                "No data exists.",
              ),
            );
          }
        },
      ),
    );
  }
}
