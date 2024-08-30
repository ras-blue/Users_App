import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:users_app/CustomerBrandScreens/customer_brands_ui_design.dart';
// import 'package:users_app/brandsScreens/brands_ui_design_widget.dart';
import 'package:users_app/c_models/sellers.dart';
// import 'package:users_app/brandsScreens/upload_brands_screen.dart';
// import 'package:users_app/global/global.dart';
import 'package:users_app/models/brands.dart';
import 'package:users_app/widgets/my_drawer.dart';
import 'package:users_app/widgets/text_delegate_header_widget.dart';
// import 'package:users_app/widgets/text_delegate_header_widget.dart';

// ignore: must_be_immutable
class CustomerBrandsScreen extends StatefulWidget {
  Vendor? model;

  CustomerBrandsScreen({this.model});
  @override
  State<CustomerBrandsScreen> createState() => _CustomerBrandsScreenState();
}

class _CustomerBrandsScreenState extends State<CustomerBrandsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        drawer: MyDrawer(),
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
            'iShop',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
        ),
        body: CustomScrollView(slivers: [
          SliverPersistentHeader(
            delegate: TextDelegateHeaderWidget(
              title: widget.model!.name.toString() + ' - Brands',
            ),
          ),
          //1. write query
          //2. model
          //3. design widget

          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('vendor')
                  .doc(widget.model!.uid.toString())
                  .collection('brands')
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
                      Brands brandsModel = Brands.fromJson(
                        dataSnapshot.data.docs[index].data()
                            as Map<String, dynamic>,
                      );
                      return CustomerBrandsUiDesign(
                        model: brandsModel,
                        context: context,
                      );
                    },
                    itemCount: dataSnapshot.data.docs.length,
                  );
                } else //if brands not exist
                {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text(
                        'No brands exist',
                      ),
                    ),
                  );
                }
              })
        ]));
  }
}
