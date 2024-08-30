import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/mainScreens/vendor_home_screen.dart';
// import 'package:users_app/splashScreen/vendor_splash_screen.dart';
import 'package:users_app/widgets/custom_text_field.dart';
import 'package:users_app/widgets/loading_dialog.dart';

class VendorLoginTabPage extends StatefulWidget {
  const VendorLoginTabPage({super.key});

  @override
  State<VendorLoginTabPage> createState() => _VendorLoginTabPageState();
}

class _VendorLoginTabPageState extends State<VendorLoginTabPage> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  validateForm() {
    if (emailTextEditingController.text.isNotEmpty &&
        passwordTextEditingController.text.isNotEmpty) {
      // allow user to login
      loginNow();
    } else {
      Fluttertoast.showToast(msg: "Pls provide email and password.");
    }
  }

  loginNow() async {
    showDialog(
        context: context,
        builder: (e) {
          return LoadingDialog(
            message: "Checking credentials",
          );
        });
    User? currentUser;

    await FirebaseAuth.instance
        .signInWithEmailAndPassword(
      email: emailTextEditingController.text.trim(),
      password: passwordTextEditingController.text.trim(),
    )
        .then((auth) {
      currentUser = auth.user;
    }).catchError((errorMessage) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: 'error occured: \n $errorMessage');
    });
    if (currentUser != null) {
      checkIfUserRecordExists(currentUser!);
    }
  }

  checkIfUserRecordExists(User currentUser) async {
    await FirebaseFirestore.instance
        .collection("vendor")
        .doc(currentUser.uid)
        .get()
        .then((record) async {
      if (record.exists) {
        if (record.data()!["status"] == "approved") {
          await sharedPreferences!.setString('uid', currentUser.uid);
          await sharedPreferences!.setString('email', record.data()!["email"]);
          await sharedPreferences!.setString('name', record.data()!["name"]);
          await sharedPreferences!
              .setString('photoUrl', record.data()!["photoUrl"]);

// send vendor to home screen
          Navigator.push(
              context, MaterialPageRoute(builder: (e) => VendorHomeScreen()));
        } else {
          FirebaseAuth.instance.signOut();
          Navigator.pop(context);
          Fluttertoast.showToast(
              msg:
                  "You have been BLOCKED by admin.\nContact Admin on WhatsApp: 07077777777");
        }
      } else {
        FirebaseAuth.instance.signOut();
        Navigator.pop(context);
        Fluttertoast.showToast(msg: "This record does not exist.");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Image.asset(
                    'images/welcome.png',
                    height: MediaQuery.of(context).size.height * 0.40,
                  ),
                ),
                //email
                CustomTextField(
                  textEditingController: emailTextEditingController,
                  iconData: Icons.email,
                  hintText: 'Email',
                  isObsecre: false,
                  enabled: true,
                ),
                //password
                CustomTextField(
                  textEditingController: passwordTextEditingController,
                  iconData: Icons.lock,
                  hintText: 'Password',
                  isObsecre: true,
                  enabled: true,
                ),

                SizedBox(
                  height: 12,
                ),
              ],
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pinkAccent,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            ),
            onPressed: () {
              validateForm();
            },
            child: Text(
              'Login',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
