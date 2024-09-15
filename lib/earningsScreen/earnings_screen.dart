import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/splashScreen/vendor_splash_screen.dart';

class EarningsScreen extends StatefulWidget {
  const EarningsScreen({super.key});

  @override
  State<EarningsScreen> createState() => _EarningsScreenState();
}

class _EarningsScreenState extends State<EarningsScreen> {
  String totalSellerEarnings = '';

  readTotalEarnings() async {
    await FirebaseFirestore.instance
        .collection('vendor')
        .doc(sharedPreferences!.getString('uid'))
        .get()
        .then((snap) {
      setState(() {
        totalSellerEarnings = snap.data()!['earnings'].toString();
      });
    });
  }

  @override
  void initState() {
    super.initState();

    readTotalEarnings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'N' + totalSellerEarnings,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Total Earnings',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
                width: 200,
                child: Divider(
                  color: Colors.white,
                  thickness: 1.5,
                ),
              ),
              SizedBox(
                height: 40.0,
              ),
              Card(
                color: Colors.white54,
                margin: EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 100,
                ),
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (c) => VendorSplashScreen(),
                      ),
                    );
                  },
                  leading: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Go Back',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
