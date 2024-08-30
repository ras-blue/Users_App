import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:users_app/VendorAuthScreens/vendor_auth_screen.dart';
import 'package:users_app/mainScreens/vendor_home_screen.dart';
// import 'package:users_app/mainScreens/home_screen.dart';
// import 'package:users_app/mainScreens/vendor_home_screen.dart';
// import 'package:users_app/welcome_screens/welcome_register_screen.dart';

class VendorSplashScreen extends StatefulWidget {
  const VendorSplashScreen({super.key});

  @override
  State<VendorSplashScreen> createState() => _VendorSplashScreenState();
}

class _VendorSplashScreenState extends State<VendorSplashScreen> {
  splashScreenTimer() {
    Timer(Duration(seconds: 4), () async {
      // seller is already logged in
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => VendorHomeScreen()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => VendorAuthScreen()));
      }
    });
  }

  @override
  void initState() {
    splashScreenTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.pinkAccent,
              Colors.purpleAccent,
            ],
            begin: FractionalOffset(
              0.0,
              0.0,
            ),
            end: FractionalOffset(
              1.0,
              0.0,
            ),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(
                  18.0,
                ),
                child: Image.asset(
                  "images/welcome.png",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'iShop Vendors App',
                style: TextStyle(
                  fontSize: 30,
                  letterSpacing: 3,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
