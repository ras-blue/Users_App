import 'package:flutter/material.dart';
import 'package:users_app/mainScreens/home_screen.dart';

// ignore: must_be_immutable
class StatusBanner extends StatelessWidget {
  bool? status;
  String? orderStatus;

  StatusBanner({
    this.status,
    this.orderStatus,
  });

  @override
  Widget build(BuildContext context) {
    String? message;
    IconData? iconData;

    status! ? iconData = Icons.done : iconData = Icons.cancel;
    status! ? message = 'Successful' : message = 'Unsuccessful';

    return Container(
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
      height: 80,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              );
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          SizedBox(
            width: 30,
          ),
          Text(
            orderStatus == 'ended'
                ? 'Parcel Delivered $message'
                : orderStatus == 'shifted'
                    ? 'Parcel Shifted $message'
                    : orderStatus == 'normal'
                        ? 'Order Placed $message'
                        : '',
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          SizedBox(
            width: 7,
          ),
          CircleAvatar(
            radius: 10,
            backgroundColor: Colors.black,
            child: Center(
              child: Icon(
                iconData,
                color: Colors.white,
                size: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}
