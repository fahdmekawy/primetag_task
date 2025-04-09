import 'package:hive/hive.dart';
import 'package:primetag_task/features/cart/domain/entities/cart.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 0)
class CartItemModel extends Cart {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final double price;

  @HiveField(3)
  final int quantity;

  @HiveField(4)
  final String image;

  CartItemModel({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
    required this.image,
  }) : super(
         id: id,
         price: price,
         quantity: quantity,
         image: image,
         title: title,
       );
}
