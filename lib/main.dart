import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:users_app/assistantMethods/cart_item_counter.dart';
import 'package:users_app/global/global.dart';
// import 'package:users_app/authScreens/auth_screen.dart';
// import 'package:users_app/splashScreen/my_splash_screen.dart';
import 'package:users_app/welcome_screens/welcome_register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  sharedPreferences = await SharedPreferences.getInstance();

  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
              apiKey: "AIzaSyDd0znvTEPKLwMKzAAetdGD1sgXfPW0U_I",
              appId: "1:609219238130:android:df6a6e4cb6907fc721186b",
              messagingSenderId: "609219238130",
              projectId: "bisell-f0f77",
              storageBucket: "gs://bisell-f0f77.appspot.com"),
        )
      : await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (c) => CartItemCounter()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: WelcomeRegisterScreen(),
      ),
    );
  }
}
