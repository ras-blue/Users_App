import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:users_app/models/items.dart';
import 'package:users_app/ordersScreens/order_details_screen.dart';

// ignore: must_be_immutable
class OrderCard extends StatefulWidget {
  int? itemCount;
  List<DocumentSnapshot>? data;
  String? orderId;
  List<String>? seperateQuantitiesList;

  OrderCard({
    this.itemCount,
    this.data,
    this.orderId,
    this.seperateQuantitiesList,
  });

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => OrderDetailsScreen(
              orderID: widget.orderId,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.black,
        elevation: 10,
        shadowColor: Colors.white54,
        child: Container(
          color: Colors.transparent,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          height: widget.itemCount! * 125,
          child: ListView.builder(
            itemCount: widget.itemCount,
            itemBuilder: (context, index) {
              Items model = Items.fromJson(
                  widget.data![index].data() as Map<String, dynamic>);
              return placeOrdersItemsDesignWidget(
                  model, context, widget.seperateQuantitiesList![index]);
            },
          ),
        ),
      ),
    );
  }
}

Widget placeOrdersItemsDesignWidget(
    Items items, BuildContext context, itemQuantity) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 120,
    color: Colors.transparent,
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            items.thumbnailUrl.toString(),
            width: 120,
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                //title and price
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        items.itemTitle.toString(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "N ",
                      style: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      items.price.toString(),
                      style: TextStyle(
                          color: Colors.purpleAccent,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      'x ',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      itemQuantity,
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
