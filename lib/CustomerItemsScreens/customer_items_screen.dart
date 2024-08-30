import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:users_app/CustomerItemsScreens/customer_items_ui_design_widget.dart';
// import 'package:users_app/global/global.dart';
// import 'package:users_app/itemScreens/items_ui_design_widget.dart';
// import 'package:users_app/itemScreens/upload_items_screen.dart';
import 'package:users_app/models/brands.dart';
import 'package:users_app/models/items.dart';
import 'package:users_app/widgets/text_delegate_header_widget.dart';

// ignore: must_be_immutable
class CustomerItemsScreen extends StatefulWidget {
  Brands? model;

  CustomerItemsScreen({
    this.model,
  });

  @override
  State<CustomerItemsScreen> createState() => _CustomerItemsScreenState();
}

class _CustomerItemsScreenState extends State<CustomerItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
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
          title: Text(
            'Vendor iShop',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: TextDelegateHeaderWidget(
                  title: widget.model!.brandTitile.toString() + ' Items'),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("vendor")
                    .doc(widget.model!.vendorUID.toString())
                    .collection("brands")
                    .doc(widget.model!.brandId)
                    .collection('items')
                    .orderBy('publishedDate', descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot dataSnapshot) {
                  //if brands exist
                  if (dataSnapshot.hasData) {
                    //display brands
                    return SliverStaggeredGrid.countBuilder(
                      crossAxisCount: 1,
                      staggeredTileBuilder: (c) => StaggeredTile.fit(1),
                      itemBuilder: (context, index) {
                        Items itemsModel = Items.fromJson(
                          dataSnapshot.data.docs[index].data()
                              as Map<String, dynamic>,
                        );
                        return CustomerItemsUiDesignWidget(
                          model: itemsModel,
                          context: context,
                        );
                      },
                      itemCount: dataSnapshot.data.docs.length,
                    );
                  } else //if items not exist
                  {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          'No items exist',
                        ),
                      ),
                    );
                  }
                })
          ],
        ));
  }
}
