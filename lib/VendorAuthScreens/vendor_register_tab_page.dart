import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:users_app/global/global.dart';
import 'package:users_app/mainScreens/vendor_home_screen.dart';
// import 'package:users_app/mainScreens/home_screen.dart';
// import 'package:users_app/splashScreen/my_splash_screen.dart';
// import 'package:users_app/splashScreen/vendor_splash_screen.dart';
import 'package:users_app/widgets/custom_text_field.dart';
import 'package:users_app/widgets/loading_dialog.dart';

class VendorRegisterTabPage extends StatefulWidget {
  const VendorRegisterTabPage({super.key});

  @override
  State<VendorRegisterTabPage> createState() => _VendorRegisterTabPageState();
}

class _VendorRegisterTabPageState extends State<VendorRegisterTabPage> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController locationTextEditingController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String downloadUrlImage = '';

  XFile? imgXFile;
  final ImagePicker imagePicker = ImagePicker();

  getImageFromGallery() async {
    imgXFile = await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imgXFile;
    });
  }

  formValidation() async {
    //image not selected
    if (imgXFile == null) {
      Fluttertoast.showToast(
        msg: 'Please select an image',
      );
    }
    //image already selected
    else {
      //password equals to confirm password
      if (passwordTextEditingController.text ==
          confirmPasswordTextEditingController.text) {
        //check email, pass, confirm pass & name text fields
        if (nameTextEditingController.text.isNotEmpty &&
            emailTextEditingController.text.isNotEmpty &&
            passwordTextEditingController.text.isNotEmpty &&
            confirmPasswordTextEditingController.text.isNotEmpty &&
            phoneTextEditingController.text.isNotEmpty &&
            locationTextEditingController.text.isNotEmpty) {
          showDialog(
              context: context,
              builder: (e) {
                return LoadingDialog(
                  message: "Registering your Account",
                );
              });
          //1.upload image to storage
          String fileName = DateTime.now().millisecondsSinceEpoch.toString();

          fStorage.Reference storageRef = fStorage.FirebaseStorage.instance
              .ref()
              .child('vendorImages')
              .child(fileName);

          fStorage.UploadTask uploadImageTask =
              storageRef.putFile(File(imgXFile!.path));

          fStorage.TaskSnapshot taskSnapshot =
              await uploadImageTask.whenComplete(() {});

          await taskSnapshot.ref.getDownloadURL().then((urlImage) {
            downloadUrlImage = urlImage;
          });
          //2.save user info to firestore db
          saveInformationToDatabase();
        } else {
          Navigator.pop(context);
          Fluttertoast.showToast(
            msg: 'do not leave empty fields',
          );
        }
      }
      //password not equal to confirm password
      else {
        Fluttertoast.showToast(
            msg: 'Password and confirm password do not match');
      }
    }
  }

  saveInformationToDatabase() async {
    //authenticate the user first
    User? currentUser;

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
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
      //save info to db and save locally
      saveInfoToFirestoreAndLocally(currentUser!);
    }
  }

  saveInfoToFirestoreAndLocally(User currentUser) async {
    //save to firestore
    FirebaseFirestore.instance.collection('vendor').doc(currentUser.uid).set({
      'uid': currentUser.uid,
      'email': currentUser.email,
      'name': nameTextEditingController.text.trim(),
      'photoUrl': downloadUrlImage,
      'phone': phoneTextEditingController.text.trim(),
      'address': phoneTextEditingController.text.trim(),
      'status': 'approved',
      'earnings': 0.0,
    });

    //save locally
    sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences!.setString('uid', currentUser.uid);
    await sharedPreferences!.setString('email', currentUser.email!);
    await sharedPreferences!
        .setString('name', nameTextEditingController.text.trim());
    await sharedPreferences!.setString('photoUrl', downloadUrlImage);

    Navigator.push(
        context, MaterialPageRoute(builder: (c) => VendorHomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            SizedBox(
              height: 12,
            ),
            //get image
            GestureDetector(
              onTap: () {
                getImageFromGallery();
              },
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.20,
                backgroundColor: Colors.white,
                backgroundImage: imgXFile == null
                    ? null
                    : FileImage(
                        File(imgXFile!.path),
                      ),
                child: imgXFile == null
                    ? Icon(
                        Icons.add_photo_alternate,
                        color: Colors.grey,
                        size: MediaQuery.of(context).size.width * 0.20,
                      )
                    : null,
              ),
            ),
            SizedBox(
              height: 12,
            ),

            //input form fields

            Form(
              key: formKey,
              child: Column(
                children: [
                  //name
                  CustomTextField(
                    textEditingController: nameTextEditingController,
                    iconData: Icons.person,
                    hintText: 'Name',
                    isObsecre: false,
                    enabled: true,
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
                  //confirm password
                  CustomTextField(
                    textEditingController: confirmPasswordTextEditingController,
                    iconData: Icons.lock,
                    hintText: 'Confirm Password',
                    isObsecre: true,
                    enabled: true,
                  ),
                  // phone
                  CustomTextField(
                    textEditingController: phoneTextEditingController,
                    iconData: Icons.lock,
                    hintText: 'Phone Number',
                    isObsecre: false,
                    enabled: true,
                  ),
                  // location
                  CustomTextField(
                    textEditingController: locationTextEditingController,
                    iconData: Icons.lock,
                    hintText: 'Location',
                    isObsecre: false,
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
                formValidation();
              },
              child: Text(
                'Sign Up',
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
      ),
    );
  }
}
