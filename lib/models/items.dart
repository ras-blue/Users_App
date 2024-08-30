import 'package:cloud_firestore/cloud_firestore.dart';

class Items {
  String? brandId;
  String? itemId;
  String? itemInfo;
  String? itemTitle;
  String? description;
  String? price;
  Timestamp? publishedDate;
  String? vendorName;
  String? vendorUID;
  String? status;
  String? thumbnailUrl;

  Items({
    this.brandId,
    this.itemId,
    this.itemInfo,
    this.itemTitle,
    this.description,
    this.price,
    this.publishedDate,
    this.vendorName,
    this.vendorUID,
    this.status,
    this.thumbnailUrl,
  });

  Items.fromJson(Map<String, dynamic> json) {
    brandId = json['brandId'];
    itemId = json['itemId'];
    itemInfo = json['itemInfo'];
    itemTitle = json['itemTitle'];
    description = json['description'];
    price = json['price'];
    publishedDate = json['publishedDate'];
    vendorName = json['vendorName'];
    vendorUID = json['vendorUID'];
    status = json['status'];
    thumbnailUrl = json['thumbnailUrl'];
  }
}
