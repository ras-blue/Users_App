import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:users_app/brandsScreens/brands_ui_design_widget.dart';
import 'package:users_app/brandsScreens/upload_brands_screen.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/models/brands.dart';
import 'package:users_app/widgets/my_drawer.dart';
import 'package:users_app/widgets/text_delegate_header_widget.dart';

class VendorHomeScreen extends StatefulWidget {
  const VendorHomeScreen({super.key});

  @override
  State<VendorHomeScreen> createState() => _VendorHomeScreenState();
}

class _VendorHomeScreenState extends State<VendorHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            'Vendor iShop',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => UploadBrandsScreen()));
              },
              icon: Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: CustomScrollView(slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: TextDelegateHeaderWidget(
              title: 'My Brands',
            ),
          ),
          //1. write query
          //2. model
          //3. design widget

          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('vendor')
                  .doc(sharedPreferences!.getString('uid'))
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
                      return BrandsUiDesignWidget(
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
