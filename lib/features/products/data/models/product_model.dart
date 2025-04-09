import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:primetag_task/features/products/domain/entities/product.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends Product{
  final int? id;
  final String? title;
  final double? price;
  final String? image;

  ProductModel({this.id, this.title, this.price, this.image});

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);
}
