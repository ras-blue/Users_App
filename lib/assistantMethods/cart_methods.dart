import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:users_app/assistantMethods/cart_item_counter.dart';
import 'package:users_app/global/global.dart';

class CartMethods {
  addItemToCart(String? itemId, int itemCounter, BuildContext context) {
    List<String>? tempList = sharedPreferences!.getStringList('userCart');
    tempList!.add(itemId.toString() + ':' + itemCounter.toString());

    //save to firestore db
    FirebaseFirestore.instance
        .collection('users')
        .doc(sharedPreferences!.getString('uid'))
        .update({
      'userCart': tempList,
    }).then((value) {
      Fluttertoast.showToast(msg: 'Item Added Successfully');
      // save to local storage
      sharedPreferences!.setStringList('userCart', tempList);
      //update item badge number
      Provider.of<CartItemCounter>(context, listen: false)
          .showCartListitemsNumber();
    });
  }

  ClearCart(BuildContext context) {
    //clear in local storage
    sharedPreferences!.setStringList('userCart', ['initialValue']);

    List<String>? emptyCartList = sharedPreferences!.getStringList('userCart');

    FirebaseFirestore.instance
        .collection('users')
        .doc(sharedPreferences!.getString('uid'))
        .update({
      'userCart': emptyCartList,
    }).then((value) {
      //update item badge number
      Provider.of<CartItemCounter>(context, listen: false)
          .showCartListitemsNumber();
    });
  }

  seperateItemIDsFromUserCartList() {
    List<String>? userCartList = sharedPreferences!.getStringList('userCart');

    List<String> itemsIDsList = [];
    for (int i = 1; i < userCartList!.length; i++) {
      String item = userCartList[i].toString();
      var lastCharacterPositionOfItemBeforeColon = item.lastIndexOf(':');

      String getItemID =
          item.substring(0, lastCharacterPositionOfItemBeforeColon);
      itemsIDsList.add(getItemID);
    }

    return itemsIDsList;
  }

  seperateItemQuantitiesFromUserCartList() {
    List<String>? userCartList = sharedPreferences!.getStringList('userCart');

    List<int> itemsQuantitiesList = [];
    for (int i = 1; i < userCartList!.length; i++) {
      String item = userCartList[i].toString();
      var colonAndAfterCharacterList = item.split(':').toList();

      var quantityNumber = int.parse(colonAndAfterCharacterList[1].toString());
      itemsQuantitiesList.add(quantityNumber);
    }

    return itemsQuantitiesList;
  }

  seperateOrderItemIDs(productIDs) {
    List<String>? userCartList = List<String>.from(productIDs);

    List<String> itemsIDsList = [];
    for (int i = 1; i < userCartList.length; i++) {
      String item = userCartList[i].toString();
      var lastCharacterPositionOfItemBeforeColon = item.lastIndexOf(':');

      String getItemID =
          item.substring(0, lastCharacterPositionOfItemBeforeColon);
      itemsIDsList.add(getItemID);
    }

    return itemsIDsList;
  }

  seperateOrderItemsQuantities(productIDs) {
    List<String>? userCartList = List<String>.from(productIDs);

    List<String> itemsQuantitiesList = [];
    for (int i = 1; i < userCartList.length; i++) {
      String item = userCartList[i].toString();
      var colonAndAfterCharacterList = item.split(':').toList();

      var quantityNumber = int.parse(colonAndAfterCharacterList[1].toString());
      itemsQuantitiesList.add(quantityNumber.toString());
    }

    return itemsQuantitiesList;
  }
}
