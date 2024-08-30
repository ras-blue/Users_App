import 'package:flutter/material.dart';
import 'package:users_app/CustomerItemsScreens/customer_items_details_screen.dart';
// import 'package:users_app/itemScreens/items_details_screen.dart';
// import 'package:users_app/itemScreens/items_screen.dart';
// import 'package:users_app/models/brands.dart';
import 'package:users_app/models/items.dart';

// ignore: must_be_immutable
class CustomerItemsUiDesignWidget extends StatefulWidget {
  Items? model;
  BuildContext? context;

  CustomerItemsUiDesignWidget({
    this.model,
    this.context,
  });

  @override
  State<CustomerItemsUiDesignWidget> createState() =>
      _CustomerItemsUiDesignWidgetState();
}

class _CustomerItemsUiDesignWidgetState
    extends State<CustomerItemsUiDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => CustomerItemsDetailsScreen(
              model: widget.model,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.black,
        elevation: 10,
        shadowColor: Colors.grey,
        child: Padding(
          padding: EdgeInsets.all(4),
          child: SizedBox(
            height: 280,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: Image.network(
                    widget.model!.thumbnailUrl.toString(),
                    height: 220,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 1,
                ),
                Text(
                  widget.model!.itemTitle.toString(),
                  style: TextStyle(
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    letterSpacing: 3,
                  ),
                ),
                SizedBox(
                  height: 1,
                ),
                Text(
                  widget.model!.itemInfo.toString(),
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
