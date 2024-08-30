import 'package:flutter/material.dart';
import 'package:users_app/models/items.dart';

// ignore: must_be_immutable
class CartItemDesignWidget extends StatefulWidget {
  Items? model;
  int? quantityNumber;

  CartItemDesignWidget({
    this.model,
    this.quantityNumber,
  });

  @override
  State<CartItemDesignWidget> createState() => _CartItemDesignWidgetState();
}

class _CartItemDesignWidgetState extends State<CartItemDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      shadowColor: Colors.white54,
      elevation: 10,
      child: SizedBox(
        height: 100,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            // image
            Image.network(
              widget.model!.thumbnailUrl.toString(),
              width: 140,
              height: 120,
            ),
            SizedBox(
              width: 6,
            ),
            Column(
              children: [
                // title
                Text(
                  widget.model!.itemTitle.toString(),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 1,
                ),
                // price: #
                Row(
                  children: [
                    Text(
                      "Price: ",
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      "# ",
                      style: TextStyle(
                        color: Colors.purpleAccent,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      widget.model!.price.toString(),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                // quantity
                Row(
                  children: [
                    Text(
                      "Quantity: ",
                      style: TextStyle(
                        color: Colors.white54,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      "x" + widget.quantityNumber.toString(),
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
