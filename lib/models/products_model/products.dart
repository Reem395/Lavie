import 'package:flutter_hackathon/models/plants_model/plants.dart';
import 'package:flutter_hackathon/models/seeds_model/seeds.dart';
import 'package:flutter_hackathon/models/tools_model/tool.dart';

class Products {
  String? productId;
  String? name;
  String? description;
  String? imageUrl;
  String? type;
  int? price;
  bool? available;
  Seeds? seed;
  Plants? plant;
  Tool? tool;

  Products({
    this.productId,
    this.name,
    this.description,
    this.imageUrl,
    this.type,
    this.price,
    this.available,
    this.seed,
    this.plant,
    this.tool,
  });

  factory Products.fromJson(Map<String, dynamic> json) => Products(
        productId: json['productId'] as String?,
        name: json['name'] as String?,
        description: json['description'] as String?,
        imageUrl: json['imageUrl'] as String?,
        type: json['type'] as String?,
        price: json['price'] as int?,
        available: json['available'] as bool?,
        seed: json['seeds'] == null
            ? null
            : Seeds.fromJson(json['seeds'] as Map<String, dynamic>),
        plant: json['plants'] == null
            ? null
            : Plants.fromJson(json['plants'] as Map<String, dynamic>),
        tool: json['tools'] == null
            ? null
            : Tool.fromJson(json['tools'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'productId': productId,
        'name': name,
        'description': description,
        'imageUrl': imageUrl,
        'type': type,
        'price': price,
        'available': available,
        'seed': seed,
        'plant': plant?.toJson(),
        'tool': tool,
      };
}
