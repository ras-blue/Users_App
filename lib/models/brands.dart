import 'package:cloud_firestore/cloud_firestore.dart';

class Brands {
  String? brandId;
  String? brandInfo;
  String? brandTitile;
  Timestamp? publishedDate;
  String? vendorUID;
  String? status;
  String? thumbnailUrl;

  Brands({
    this.brandId,
    this.brandInfo,
    this.brandTitile,
    this.publishedDate,
    this.vendorUID,
    this.status,
    this.thumbnailUrl,
  });

  Brands.fromJson(Map<String, dynamic> json) {
    brandId = json['brandId'];
    brandInfo = json['brandInfo'];
    brandTitile = json['brandTitile'];
    publishedDate = json['publishedDate'];
    vendorUID = json['vendorUID'];
    status = json['status'];
    thumbnailUrl = json['thumbnailUrl'];
  }
}
