
import 'package:flutter_hackathon/models/products_model/products.dart';

class ProductSingleModel {
  String? type;
  String? message;
  Products? data;

  ProductSingleModel({this.type, this.message, this.data});

  factory ProductSingleModel.fromJson(Map<String, dynamic> json) {
    try {
      
    return ProductSingleModel(
      type: json['type'] as String?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : Products.fromJson(json['data'] as Map<String, dynamic>),
    );
    } catch (e) {
      return ProductSingleModel();
    }
  }

  Map<String, dynamic> toJson() => {
        'type': type,
        'message': message,
        'data': data?.toJson(),
      };
}
