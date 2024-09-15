import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:users_app/VendorOrderScreens/vendor_address_design_widget.dart';
// import 'package:users_app/global/global.dart';
import 'package:users_app/models/address.dart';
// import 'package:users_app/ordersScreens/address_design_widget.dart';
import 'package:users_app/ordersScreens/status_banner.dart';

// ignore: must_be_immutable
class VendorOrderDetailsScreen extends StatefulWidget {
  String? orderID;

  VendorOrderDetailsScreen({
    this.orderID,
  });

  @override
  State<VendorOrderDetailsScreen> createState() =>
      _VendorOrderDetailsScreenState();
}

class _VendorOrderDetailsScreenState extends State<VendorOrderDetailsScreen> {
  String orderStatus = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('orders')
              .doc(widget.orderID)
              .get(),
          builder: (c, AsyncSnapshot dataSnapshot) {
            Map? orderDataMap;
            if (dataSnapshot.hasData) {
              orderDataMap = dataSnapshot.data.data() as Map<String, dynamic>;
              orderStatus = orderDataMap['status'].toString();

              return Column(
                children: [
                  StatusBanner(
                    status: orderDataMap['isSuccess'],
                    orderStatus: orderStatus,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'N ' + orderDataMap['totalAmount'].toString(),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Order ID = ' + orderDataMap['orderId'].toString(),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Order at = ' +
                            DateFormat('dd MMMM, yyyy - hh:mm aa').format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    int.parse(orderDataMap['orderTime']))),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.pinkAccent,
                  ),
                  orderStatus == 'ended'
                      ? Image.asset(
                          'images/StockCake-Stormy Sea Watch_1719332508.jpg')
                      : Image.asset(
                          'images/StockCake-Beachside Lifeguard Watch_1719332453.jpg'),
                  Divider(
                    thickness: 1,
                    color: Colors.pinkAccent,
                  ),
                  FutureBuilder(
                    future: FirebaseFirestore.instance
                        .collection("users")
                        .doc(orderDataMap['orderBy'])
                        .collection("userAddress")
                        .doc(orderDataMap["addressID"])
                        .get(),
                    builder: (c, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        return VendorAddressDesign(
                          model: Address.fromJson(
                              snapshot.data.data() as Map<String, dynamic>),
                          orderStatus: orderStatus,
                          orderId: widget.orderID,
                          vendorId: orderDataMap!["vendorUID"],
                          orderByUser: orderDataMap["orderBy"],
                          totalAmount: orderDataMap['totalAmount'].toString(),
                        );
                      } else {
                        return Center(
                          child: Text(
                            "No data exists...",
                          ),
                        );
                      }
                    },
                  ),
                ],
              );
            } else {
              return Center(
                child: Text(
                  'No data exists.',
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
