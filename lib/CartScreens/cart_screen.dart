import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:users_app/CartScreens/cart_item_design_widget.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/models/items.dart';
import 'package:users_app/splashScreen/my_splash_screen.dart';
import 'package:users_app/widgets/appbar_cart_badge.dart';

// ignore: must_be_immutable
class CartScreen extends StatefulWidget {
  String? vendorUID;

  CartScreen({
    this.vendorUID,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<int>? itemQuantityList;

  @override
  void initState() {
    super.initState();

    itemQuantityList = cartMethods.seperateItemQuantitiesFromUserCartList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarCartBadge(),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 10,
          ),
          FloatingActionButton.extended(
            onPressed: () {
              cartMethods.ClearCart(context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => MySplashScreen(),
                ),
              );
            },
            heroTag: 'btn1',
            icon: Icon(
              Icons.clear_all,
            ),
            label: Text(
              'Clear Cart',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
          FloatingActionButton.extended(
            onPressed: () {},
            heroTag: 'btn2',
            icon: Icon(
              Icons.navigate_next,
            ),
            label: Text(
              'Check Out',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              color: Colors.black45,
              child: Text(
                'Total Price: ' + '240',
              ),
            ),
          ),
          // query
          // model
          // design
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("items")
                .where("itemId",
                    whereIn: cartMethods.seperateItemIDsFromUserCartList())
                .orderBy("publishedDate", descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot dataSnapshot) {
              if (dataSnapshot.hasData) {
                // display
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      Items model = Items.fromJson(dataSnapshot.data.docs[index]
                          .data() as Map<String, dynamic>);
                      return CartItemDesignWidget(
                        model: model,
                        quantityNumber: itemQuantityList![index],
                      );
                    },
                    childCount: dataSnapshot.data.docs.length,
                  ),
                );
              } else {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text("No Items In Cart"),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
