import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:users_app/CartScreens/cart_screen.dart';
import 'package:users_app/assistantMethods/cart_item_counter.dart';

// ignore: must_be_immutable
class AppbarCartBadge extends StatefulWidget implements PreferredSizeWidget {
  PreferredSizeWidget? preferredSizeWidget;
  String? vendorUID;

  AppbarCartBadge({
    this.preferredSizeWidget,
    this.vendorUID,
  });

  @override
  State<AppbarCartBadge> createState() => _AppbarCartBadgeState();

  @override
  Size get preferredSize => preferredSizeWidget == null
      ? Size(56, AppBar().preferredSize.height)
      : Size(56, 80 + AppBar().preferredSize.height);
}

class _AppbarCartBadgeState extends State<AppbarCartBadge> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
      automaticallyImplyLeading: true,
      title: Text(
        'iShop',
        style: TextStyle(
          fontSize: 20,
          letterSpacing: 3,
        ),
      ),
      centerTitle: true,
      actions: [
        Stack(
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (c) => CartScreen(
                      vendorUID: widget.vendorUID,
                    ),
                  ),
                );
              },
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            ),
            Positioned(
              child: Stack(children: [
                Icon(
                  Icons.brightness_1,
                  size: 20,
                  color: Colors.deepPurpleAccent,
                ),
                Positioned(
                  top: 2,
                  right: 6,
                  child: Center(
                    child: Consumer<CartItemCounter>(
                      builder: (context, counter, c) {
                        return Text(
                          counter.count.toString(),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ]),
            ),
          ],
        )
      ],
    );
  }
}
