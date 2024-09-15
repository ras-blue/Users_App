import 'package:shared_preferences/shared_preferences.dart';
import 'package:users_app/assistantMethods/cart_methods.dart';

SharedPreferences? sharedPreferences;

final itemsImagesList = [
  "slider/1a1d2c1b317e4c54b21c2cdecb3e8354.jpg",
  "slider/2ec7689de4af4b5f92fad23aece0a2e2.jpg",
  "slider/9f8bf2ca38d14e778621f22e1915fcda.jpg",
  "slider/77ea0a8096c140adb0b80451773479cf.jpg",
  "slider/1529a509f2cf4118b077f183c54fa03c.jpg",
  "slider/87119bbcc67b4bb283e4f3361f838f08.jpg",
];

CartMethods cartMethods = CartMethods();
String previousEarning = '';
double countStarsRating = 0.0;
String titleStarsRating = '';
