import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/splashScreen/my_splash_screen.dart';

// ignore: must_be_immutable
class RateSellerScreen extends StatefulWidget {
  String? vendorId;

  RateSellerScreen({
    this.vendorId,
  });

  @override
  State<RateSellerScreen> createState() => _RateSellerScreenState();
}

class _RateSellerScreenState extends State<RateSellerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Dialog(
        backgroundColor: Colors.white60,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          margin: EdgeInsets.all(8),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(7),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 22,
              ),
              Text(
                'Rate this seller',
                style: TextStyle(
                  fontSize: 22,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Divider(
                height: 4,
                thickness: 4,
              ),
              SizedBox(
                height: 22,
              ),
              SmoothStarRating(
                rating: countStarsRating,
                allowHalfRating: true,
                starCount: 5,
                color: Colors.purpleAccent,
                borderColor: Colors.purpleAccent,
                size: 46,
                onRatingChanged: (valueOfStarsChoosed) {
                  countStarsRating = valueOfStarsChoosed;

                  if (countStarsRating == 1) {
                    setState(() {
                      titleStarsRating = 'Very bad';
                    });
                  }
                  if (countStarsRating == 2) {
                    setState(() {
                      titleStarsRating = 'Bad';
                    });
                  }
                  if (countStarsRating == 3) {
                    setState(() {
                      titleStarsRating = 'Good';
                    });
                  }
                  if (countStarsRating == 4) {
                    setState(() {
                      titleStarsRating = 'Very good';
                    });
                  }
                  if (countStarsRating == 5) {
                    setState(() {
                      titleStarsRating = 'Excellent';
                    });
                  }
                },
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                titleStarsRating,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.purpleAccent,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection('vendor')
                      .doc(widget.vendorId)
                      .get()
                      .then((snap) {
                    //seller not yet received rating from any user
                    if (snap.data()!['ratings'] == null) {
                      FirebaseFirestore.instance
                          .collection('vendor')
                          .doc(widget.vendorId)
                          .update({
                        'ratings': countStarsRating.toString(),
                      });
                    }
                    //seller has already received rating from any user
                    else {
                      double pastRatings =
                          double.parse(snap.data()!['ratings'].toString());
                      double newRatings = (pastRatings + countStarsRating) / 2;

                      FirebaseFirestore.instance
                          .collection('vendor')
                          .doc(widget.vendorId)
                          .update({
                        'ratings': newRatings.toString(),
                      });
                    }
                    Fluttertoast.showToast(msg: 'Rated Successfully');

                    setState(() {
                      countStarsRating = 0.0;
                      titleStarsRating = '';
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (c) => MySplashScreen(),
                      ),
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purpleAccent,
                  padding: EdgeInsets.symmetric(horizontal: 74),
                ),
                child: Text(
                  'Submit',
                ),
              ),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
