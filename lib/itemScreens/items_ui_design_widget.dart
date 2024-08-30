import 'package:flutter/material.dart';
import 'package:users_app/itemScreens/items_details_screen.dart';
// import 'package:users_app/itemScreens/items_screen.dart';
// import 'package:users_app/models/brands.dart';
import 'package:users_app/models/items.dart';

// ignore: must_be_immutable
class ItemsUiDesignWidget extends StatefulWidget {
  Items? model;
  BuildContext? context;

  ItemsUiDesignWidget({
    this.model,
    this.context,
  });

  @override
  State<ItemsUiDesignWidget> createState() => _ItemsUiDesignWidgetState();
}

class _ItemsUiDesignWidgetState extends State<ItemsUiDesignWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (c) => ItemsDetailsScreen(
              model: widget.model,
            ),
          ),
        );
      },
      child: Card(
        elevation: 10,
        shadowColor: Colors.black,
        child: Padding(
          padding: EdgeInsets.all(4),
          child: SizedBox(
            height: 280,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                SizedBox(
                  height: 2,
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
                  height: 2,
                ),
                Image.network(
                  widget.model!.thumbnailUrl.toString(),
                  height: 220,
                  fit: BoxFit.cover,
                ),
                SizedBox(
                  height: 4,
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
