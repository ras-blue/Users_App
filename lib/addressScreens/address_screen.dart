import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users_app/addressScreens/address_design_widget.dart';
import 'package:users_app/addressScreens/save_new_address_screen.dart';
import 'package:users_app/assistantMethods/address_changer.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/models/address.dart';

// ignore: must_be_immutable
class AddressScreen extends StatefulWidget {
  String? vendorUID;
  double? totalAmount;

  AddressScreen({
    this.vendorUID,
    this.totalAmount,
  });

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
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
          'iShop',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (c) => SaveNewAddressScreen(
                vendorUID: widget.vendorUID.toString(),
                totalAmount: widget.totalAmount!.toDouble(),
              ),
            ),
          );
        },
        label: Text(
          'Add New Address',
        ),
        icon: Icon(
          Icons.add_location,
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          // query
          // model
          // design

          Consumer<AddressChanger>(builder: (context, address, c) {
            return Flexible(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(sharedPreferences!.getString("uid"))
                    .collection("userAddress")
                    .snapshots(),
                builder: (context, AsyncSnapshot dataSnapshot) {
                  if (dataSnapshot.hasData) {
                    if (dataSnapshot.data.docs.length > 0) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return AddressDesignWidget(
                            addressModel: Address.fromJson(
                                dataSnapshot.data.docs[index].data()
                                    as Map<String, dynamic>),
                            index: address.count,
                            value: index,
                            addressID: dataSnapshot.data.docs[index].id,
                            totalAmount: widget.totalAmount,
                            vendorUID: widget.vendorUID,
                          );
                        },
                        itemCount: dataSnapshot.data.docs.length,
                      );
                    } else {
                      return Container();
                    }
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
          }),
        ],
      ),
    );
  }
}
