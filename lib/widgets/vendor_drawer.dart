import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:users_app/ShiftedParcelsScreen/shifted_parcels_screen.dart';
import 'package:users_app/VendorOrderScreens/vendor_order_screen.dart';
import 'package:users_app/earningsScreen/earnings_screen.dart';
// import 'package:users_app/CustomersAuthScreens/customer_auth_screen.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/history/vendor_history.dart';
// import 'package:users_app/mainScreens/home_screen.dart';
import 'package:users_app/mainScreens/vendor_home_screen.dart';
// import 'package:users_app/ordersScreens/orders_screen.dart';
// import 'package:users_app/splashScreen/my_splash_screen.dart';
import 'package:users_app/welcome_screens/welcome_register_screen.dart';

class VendorDrawer extends StatefulWidget {
  const VendorDrawer({super.key});

  @override
  State<VendorDrawer> createState() => _VendorDrawerState();
}

class _VendorDrawerState extends State<VendorDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.black54,
      child: ListView(
        children: [
          //header
          Container(
            padding: EdgeInsets.only(
              top: 26,
              bottom: 12,
            ),
            child: Column(
              children: [
                //user profile image
                SizedBox(
                  height: 120,
                  width: 120,
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                      sharedPreferences!.getString('photoUrl')!,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),

                //user name
                Text(
                  sharedPreferences!.getString('name')!,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          //body
          Container(
            padding: EdgeInsets.only(
              top: 1,
            ),
            child: Column(
              children: [
                Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                //home
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Colors.grey,
                  ),
                  title: Text(
                    'Home',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => VendorHomeScreen()));
                  },
                ),
                Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
                //Earnings
                ListTile(
                  leading: Icon(
                    Icons.monetization_on,
                    color: Colors.grey,
                  ),
                  title: Text(
                    'Earnings',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => EarningsScreen()));
                  },
                ),
                Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

                //my orders
                ListTile(
                  leading: Icon(
                    Icons.reorder,
                    color: Colors.grey,
                  ),
                  title: Text(
                    'New Orders',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (c) => VendorOrderScreen()));
                  },
                ),
                Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

                //not yet received orders
                ListTile(
                  leading: Icon(
                    Icons.picture_in_picture_rounded,
                    color: Colors.grey,
                  ),
                  title: Text(
                    'Shifted Parcels',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (c) => ShiftedParcelsScreen(),
                      ),
                    );
                  },
                ),
                Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

                //history
                ListTile(
                  leading: Icon(
                    Icons.access_time,
                    color: Colors.grey,
                  ),
                  title: Text(
                    'History',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (c) => VendorHistory(),
                      ),
                    );
                  },
                ),
                Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),

                //logout
                ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Colors.grey,
                  ),
                  title: Text(
                    'sign out',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => WelcomeRegisterScreen()));
                  },
                ),
                Divider(
                  height: 10,
                  color: Colors.grey,
                  thickness: 2,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
