import 'package:flutter/material.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';
import 'package:users_app/CustomerBrandScreens/customer_brands_screen.dart';
import 'package:users_app/c_models/sellers.dart';

// ignore: must_be_immutable
class SellersUiDesignWidget extends StatefulWidget {
  Vendor? model;

  SellersUiDesignWidget({
    this.model,
  });

  @override
  State<SellersUiDesignWidget> createState() => _SellersUiDesignWidgetState();
}

class _SellersUiDesignWidgetState extends State<SellersUiDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //send user to a sellers brands screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => CustomerBrandsScreen(
              model: widget.model,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.black54,
        elevation: 20,
        shadowColor: Colors.grey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SizedBox(
            height: 270,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    widget.model!.photoUrl.toString(),
                    height: 220,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  height: 1,
                ),
                Text(
                  widget.model!.name.toString(),
                  style: TextStyle(
                    color: Colors.pinkAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SmoothStarRating(
                  rating: widget.model!.ratings == null
                      ? 0.0
                      : double.parse(widget.model!.ratings.toString()),
                  starCount: 5,
                  color: Colors.pinkAccent,
                  borderColor: Colors.pinkAccent,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
