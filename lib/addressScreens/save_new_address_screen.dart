import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users_app/addressScreens/text_field_address_widget.dart';
import 'package:users_app/global/global.dart';

// ignore: must_be_immutable
class SaveNewAddressScreen extends StatefulWidget {
  String? vendorUID;
  double? totalAmount;

  SaveNewAddressScreen({
    this.vendorUID,
    this.totalAmount,
  });

  @override
  State<SaveNewAddressScreen> createState() => _SaveNewAddressScreenState();
}

class _SaveNewAddressScreenState extends State<SaveNewAddressScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController streetNumber = TextEditingController();
  TextEditingController flatHouseNumber = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController stateCountry = TextEditingController();
  String completeAddress = '';
  final formKey = GlobalKey<FormState>();

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
          completeAddress = streetNumber.text.trim() +
              ', ' +
              flatHouseNumber.text.trim() +
              ', ' +
              city.text.trim() +
              ', ' +
              stateCountry.text.trim();

          if (formKey.currentState!.validate()) {
            FirebaseFirestore.instance
                .collection('users')
                .doc(sharedPreferences!.getString('uid'))
                .collection('userAddress')
                .doc(DateTime.now().millisecondsSinceEpoch.toString())
                .set({
              'name': name.text.trim(),
              'phoneNumber': phoneNumber.text.trim(),
              'streetNumber': streetNumber.text.trim(),
              'flatHouseNumber': flatHouseNumber.text.trim(),
              'city': city.text.trim(),
              'stateCountry': stateCountry.text.trim(),
              'completeAddress': completeAddress,
            }).then((value) {
              Fluttertoast.showToast(
                  msg: 'New Shipment Address has been saved');
              formKey.currentState!.reset();
            });
          }
        },
        label: Text(
          'Save Now',
        ),
        icon: Icon(
          Icons.save,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                'Save New Address:',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Form(
              key: formKey,
              child: Column(
                children: [
                  TextFieldAddressWidget(
                    hint: 'Name',
                    controller: name,
                  ),
                  TextFieldAddressWidget(
                    hint: 'Phone Number',
                    controller: phoneNumber,
                  ),
                  TextFieldAddressWidget(
                    hint: 'Street Number',
                    controller: streetNumber,
                  ),
                  TextFieldAddressWidget(
                    hint: 'flat house number',
                    controller: flatHouseNumber,
                  ),
                  TextFieldAddressWidget(
                    hint: 'City',
                    controller: city,
                  ),
                  TextFieldAddressWidget(
                    hint: 'State/Country',
                    controller: stateCountry,
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
